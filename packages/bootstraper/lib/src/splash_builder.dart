part of 'bootstrap.dart';

/// A widget that manages splash screen display and splash task execution.
///
/// **CRITICAL**: This widget **MUST** be used in the `builder` property of
/// [MaterialApp], [CupertinoApp], or similar app-level widgets. It cannot be
/// used as a regular widget in the widget tree.
///
/// ## Why Use in MaterialApp Builder?
///
/// The [SplashBuilder] needs to intercept the entire app's widget tree to:
/// - Display splash screens while tasks are running
/// - Handle task errors and provide retry functionality
/// - Control when the main app UI becomes visible
/// - Manage the transition between splash and main app
///
/// ## How It Works
///
/// 1. **No Config**: If no splash configuration is provided, returns the child immediately
/// 2. **Tasks Running**: While splash tasks are executing, shows the splash screen
/// 3. **Tasks Complete**: When all tasks finish successfully, shows the main app
/// 4. **Error Handling**: If tasks fail, shows error UI with retry option
///
/// ## Splash Task Execution Flow
///
/// The splash system executes tasks with different execution behaviors:
///
/// ### Execution Order and Behavior
/// 1. **Stateless Tasks**:
///    - Execute once per application lifetime when successful
///    - Run sequentially to maintain initialization order
///    - No cleanup needed, no dependency watching
///
/// 2. **Stateful Tasks**:
///    - May run multiple times based on dependency changes
///    - Can watch providers and re-execute when dependencies change
///    - Can provide disposal callbacks for resource cleanup
///
/// 3. **Error Recovery**:
///    - Failed tasks can be retried by invalidating providers
///    - All initialized tasks are properly disposed before retry
///    - Clean state ensured for retry attempts
///
/// ## Required Setup Example
///
/// ```dart
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: 'My App',
///       // CRITICAL: SplashBuilder MUST be in the builder function
///       builder: (context, child) => SplashBuilder(child: child!),
///       home: HomePage(),
///       // ... other MaterialApp properties
///     );
///   }
/// }
///
/// // Configure splash system in main()
/// void main() async {
///   await Bootstraper.initialize(
///     application: MyApp(),
///     environment: IntegrationMode.development,
///     logger: (container) => Logger('MyApp'),
///     splashConfig: SplashConfig(
///       tasks: [
///         // One-time tasks: Run once per app lifetime when successful
///         ThemeInitializationTask(),    // OneTimeSplashTask - Load theme once per app lifetime
///         ConfigurationLoadTask(),      // OneTimeSplashTask - Load config once per app lifetime
///
///         // Reactive tasks: Precise control over splash triggers
///         AuthenticationTask(),         // ReactiveSplashTask - Re-runs when auth state changes
///         UserDataLoadTask(),          // ReactiveSplashTask - Re-runs when user changes
///       ],
///       pageBuilder: (error, retry) {
///         if (error != null) {
///           return ErrorSplashPage(
///             error: error,
///             onRetry: retry,
///           );
///         }
///         return LoadingSplashPage();
///       },
///     ),
///   );
/// }
/// ```
///
/// ## Common Integration Patterns
///
/// ### With Theme and Routing
/// ```dart
/// MaterialApp(
///   title: 'My App',
///   theme: ThemeData.light(),
///   darkTheme: ThemeData.dark(),
///   // SplashBuilder wraps the entire navigation system
///   builder: (context, child) => SplashBuilder(child: child!),
///   initialRoute: '/',
///   routes: {
///     '/': (context) => HomePage(),
///     '/login': (context) => LoginPage(),
///   },
/// )
/// ```
///
/// ### With Router (GoRouter, etc.)
/// ```dart
/// MaterialApp.router(
///   title: 'My App',
///   routerConfig: appRouter,
///   // SplashBuilder intercepts before any routing occurs
///   builder: (context, child) => SplashBuilder(child: child!),
/// )
/// ```
///
/// ## Error Handling
///
/// When splash tasks fail:
/// - The error is passed to the splash page builder
/// - A retry callback is provided to re-run failed tasks
/// - Calling retry invalidates reactive tasks, causing them to re-execute
/// - The splash screen remains visible during retry attempts
///
/// ## Important Notes
///
/// - **Cannot be used as a regular widget**: Must be in app builder function
/// - **Wraps entire app**: Controls visibility of the complete app UI
/// - **Handles navigation**: Works with any routing solution (named routes, GoRouter, etc.)
/// - **Theme integration**: Splash pages have access to app theme and localization
/// - **State management**: Uses Riverpod providers for task state management
///
/// See also:
/// - [SplashConfig] for configuring splash behavior
/// - [OneTimeSplashTask] for one-time initialization tasks
/// - [ReactiveSplashTask] for reactive tasks that respond to state changes
class SplashBuilder extends ConsumerStatefulWidget {
  /// Creates a splash builder that manages splash screen display.
  ///
  /// **CRITICAL**: This widget must be used in the `builder` property of
  /// [MaterialApp] or similar app-level widgets, not as a regular widget.
  ///
  /// The [child] parameter will be the main app UI that gets shown after
  /// all splash tasks complete successfully.
  ///
  /// Example:
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => SplashBuilder(child: child!),
  ///   home: HomePage(),
  /// )
  /// ```
  const SplashBuilder({super.key, required this.child});

  /// The main application widget to display after splash tasks complete.
  ///
  /// This is typically the result of MaterialApp's routing system,
  /// whether using named routes, Router, or any other navigation solution.
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashBuilderState();
}

class _SplashBuilderState extends ConsumerState<SplashBuilder> {
  /// Tracks which reactive tasks need to execute due to watch value changes.
  /// 
  /// When a reactive task's watch value changes, its index is added to this set.
  /// The task is removed once its execution completes successfully.
  // ignore: prefer_final_fields
  Set<int> _changedWatchValues = {};

  /// Tracks the loading state of each reactive task's watch provider.
  /// 
  /// Maps task index to loading state:
  /// - `true`: Watch provider is loading
  /// - `false`: Watch provider has completed (success or error)
  // ignore: prefer_final_fields
  Map<int, bool> _activeWatchValues = {};

  /// Tracks the loading state of each reactive task's execute provider.
  /// 
  /// Maps task index to loading state:
  /// - `true`: Execute provider is loading
  /// - `false`: Execute provider has completed (success or error)
  // ignore: prefer_final_fields
  Map<int, bool> _activeExecuteTasks = {};

  /// Determines if any reactive tasks are currently loading or need execution.
  /// 
  /// Returns `true` if:
  /// - Any tasks have changed watch values and need execution
  /// - Any watch providers are currently loading
  /// - Any execute providers are currently loading
  bool get isReactiveTasksLoading {
    return _changedWatchValues.isNotEmpty ||
        _activeWatchValues.values.any((isLoading) => isLoading) ||
        _activeExecuteTasks.values.any((isLoading) => isLoading);
  }

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  /// Sets up listeners for reactive splash tasks.
  /// 
  /// This method:
  /// 1. Initializes all reactive tasks as "changed" for initial execution
  /// 2. Sets up watch provider listeners to detect value changes
  /// 3. Sets up execute provider listeners to track execution completion
  void _setupListeners() {
    final config = ref.read(_splashConfigProvider);
    if (config == null) return;

    final reactiveTasks = _filterTasksByType<ReactiveSplashTask>(config.tasks);

    // Initialize all reactive tasks as changed for initial execution
    _initializeTaskStates(reactiveTasks.length);
    
    // Set up listeners for each reactive task
    for (int taskIndex = 0; taskIndex < reactiveTasks.length; taskIndex++) {
      _setupWatchProviderListener(taskIndex);
      _setupExecuteProviderListener(taskIndex);
    }
  }

  /// Initializes the state tracking for all reactive tasks.
  /// 
  /// On initial load, all tasks are marked as changed and loading
  /// to ensure they execute at least once.
  void _initializeTaskStates(int taskCount) {
    for (int i = 0; i < taskCount; i++) {
      _changedWatchValues.add(i);
      _activeWatchValues[i] = true;
      _activeExecuteTasks[i] = true;
    }
  }

  /// Sets up a listener for a reactive task's watch provider.
  /// 
  /// This listener:
  /// - Detects when the watch value actually changes
  /// - Tracks the loading state of the watch provider
  /// - Adds tasks to execution queue when values change
  void _setupWatchProviderListener(int taskIndex) {
    ref.listenManual(_reactiveSplashTaskWatchProvider(taskIndex), (previous, next) {
      setState(() {
        // Check if watch value actually changed (not just provider state)
        if (previous?.value != next.value) {
          _changedWatchValues.add(taskIndex);
        }

        // Update watch provider loading state
        _activeWatchValues[taskIndex] = !next.hasValue;
      });
    });
  }

  /// Sets up a listener for a reactive task's execute provider.
  /// 
  /// This listener:
  /// - Only tracks execution for tasks that are in the changed queue
  /// - Updates execute provider loading state
  /// - Removes completed tasks from the execution queue
  void _setupExecuteProviderListener(int taskIndex) {
    ref.listenManual(_reactiveSplashTaskExecuteProvider(taskIndex), (previous, next) {
      // Only track execution for tasks that need to execute
      if (_changedWatchValues.contains(taskIndex)) {
        setState(() {
          if (next.hasValue) {
            // Task execution completed successfully
            _activeExecuteTasks[taskIndex] = false;
            _changedWatchValues.remove(taskIndex);
          } else {
            // Task is loading or failed
            _activeExecuteTasks[taskIndex] = true;
          }
        });
      }
    });
  }

  /// Determines whether the splash screen should be shown.
  /// 
  /// Returns `true` if:
  /// - One-time splash tasks are still loading
  /// - Reactive tasks are loading or need execution
  /// - Configuration allows showing splash on dependency changes
  bool _shouldShowSplash(SplashConfig config, AsyncValue<bool> oneTimeSplashTask) {
    // Always show splash during one-time task loading
    if (!oneTimeSplashTask.hasValue) {
      return true;
    }

    // Show splash if reactive tasks are loading
    if (isReactiveTasksLoading) {
      // Check if dependency splash is disabled
      if (!config.showSplashWhenDependencyChanged && oneTimeSplashTask.hasValue) {
        // Clear all reactive task states if dependency splash is disabled
        _clearReactiveTaskStates();
        return false;
      }
      return true;
    }

    return false;
  }

  /// Clears all reactive task states when dependency splash is disabled.
  void _clearReactiveTaskStates() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          for (int i = 0; i < _activeExecuteTasks.length; i++) {
            _activeExecuteTasks[i] = false;
            _activeWatchValues[i] = false;
          }
          _changedWatchValues.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if splash configuration is provided
    final config = ref.watch(_splashConfigProvider);
    if (config == null) {
      // No splash config = show main app immediately
      return widget.child;
    }

    // Watch one-time splash tasks
    final oneTimeSplashTask = ref.watch(_statelessSplashTaskProvider);

    // Determine if splash should be shown
    final shouldShowSplash = _shouldShowSplash(config, oneTimeSplashTask);

    if (!shouldShowSplash) {
      // All tasks completed successfully = show main app
      return widget.child;
    }

    // Tasks are still running or failed = show splash screen
    return config.pageBuilder(
      // Get the first error from any task
      _getFirstError(ref, config, oneTimeSplashTask),
      // Provide retry callback only if there are errors
      _hasAnyError(ref, config, oneTimeSplashTask) ? _createRetryCallback(oneTimeSplashTask) : null,
    );
  }

  /// Creates a retry callback for failed splash tasks.
  /// 
  /// The callback:
  /// 1. Invalidates all reactive task providers to trigger fresh execution
  /// 2. Invalidates one-time task provider if it failed
  /// 3. Resets all tracking state for a clean retry
  /// 4. Re-establishes listeners for reactive tasks
  VoidCallback _createRetryCallback(AsyncValue<bool> oneTimeSplashTask) {
    return () {
      // Retry failed reactive tasks by invalidating tracked family providers
      for (final taskIndex in _activeExecuteTasks.keys) {
        ref.invalidate(_reactiveSplashTaskWatchProvider(taskIndex));
        ref.invalidate(_reactiveSplashTaskExecuteProvider(taskIndex));
      }

      // Retry failed one-time tasks
      if (oneTimeSplashTask.hasError) {
        ref.invalidate(_statelessSplashTaskProvider);
      }

      // Reset tracking state for fresh retry
      setState(() {
        _activeExecuteTasks.clear();
        _activeWatchValues.clear();
        _changedWatchValues.clear();
      });

      // Re-setup listeners
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setupListeners();
      });
    };
  }

  /// Gets the first error from any task (one-time or reactive).
  Object? _getFirstError(WidgetRef ref, SplashConfig config, AsyncValue<bool> oneTimeTask) {
    // Check one-time task error first
    if (oneTimeTask.hasError) {
      return oneTimeTask.error;
    }

    // Check reactive task errors
    final tasks = _filterTasksByType<ReactiveSplashTask>(config.tasks);
    for (int i = 0; i < tasks.length; i++) {
      final watchState = ref.read(_reactiveSplashTaskWatchProvider(i));
      if (watchState.hasError) {
        return watchState.error;
      }

      final executeState = ref.read(_reactiveSplashTaskExecuteProvider(i));
      if (executeState.hasError) {
        return executeState.error;
      }
    }

    return null;
  }

  /// Checks if any task (one-time or reactive) has an error.
  bool _hasAnyError(WidgetRef ref, SplashConfig config, AsyncValue<bool> oneTimeTask) {
    // Check one-time task error
    if (oneTimeTask.hasError) {
      return true;
    }

    // Check reactive task errors
    final tasks = _filterTasksByType<ReactiveSplashTask>(config.tasks);
    for (int i = 0; i < tasks.length; i++) {
      final watchState = ref.read(_reactiveSplashTaskWatchProvider(i));
      if (watchState.hasError) {
        return true;
      }

      final executeState = ref.read(_reactiveSplashTaskExecuteProvider(i));
      if (executeState.hasError) {
        return true;
      }
    }

    return false;
  }
}
