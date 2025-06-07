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
/// - Calling retry invalidates stateful tasks, causing them to re-execute
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
/// - [StatelessSplashTask] for one-time initialization tasks
/// - [StatefulSplashTask] for reactive tasks that respond to state changes
class SplashBuilder extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if splash configuration is provided
    final config = ref.watch(_splashConfigProvider);
    if (config == null) {
      // No splash config = show main app immediately
      return child;
    }

    // Watch all task execution states: one-time, stateful (deprecated), and reactive
    final oneTimeSplashTask = ref.watch(_statelessSplashTaskProvider);
    final statefulSplashTasks = ref.watch(_statefulSplashTaskProvider);
    
    // For reactive tasks, we need to watch the watch phase to control splash display
    final reactiveSplashTaskWatch = ref.watch(_reactiveSplashTaskWatchProvider);
    final reactiveSplashTaskExecute = ref.watch(_reactiveSplashTaskExecuteProvider);

    // Determine if we should show splash based on task states
    final shouldShowSplash = _shouldShowSplash(
      config: config,
      oneTimeTask: oneTimeSplashTask,
      statefulTasks: statefulSplashTasks,
      reactiveWatchTask: reactiveSplashTaskWatch,
      reactiveExecuteTask: reactiveSplashTaskExecute,
    );

    if (!shouldShowSplash) {
      // All tasks completed successfully = show main app
      return child;
    }

    // Tasks are still running or failed = show splash screen
    // Pass error (if any) and retry callback to the splash page builder
    return config.pageBuilder(
      // Show the first error encountered (prioritize one-time task errors, then stateful, then reactive)
      oneTimeSplashTask.error ?? 
      statefulSplashTasks.error ?? 
      reactiveSplashTaskWatch.error ?? 
      reactiveSplashTaskExecute.error,
      // Provide retry callback only if there are errors
      oneTimeSplashTask.hasError || 
      statefulSplashTasks.hasError || 
      reactiveSplashTaskWatch.hasError || 
      reactiveSplashTaskExecute.hasError
          ? () {
              // Retry failed reactive tasks
              if (reactiveSplashTaskWatch.hasError || reactiveSplashTaskExecute.hasError) {
                ref.invalidate(_reactiveSplashTaskWatchProvider);
                ref.invalidate(_reactiveSplashTaskExecuteProvider);
              }

              // Retry failed stateful tasks
              if (statefulSplashTasks.hasError) {
                ref.invalidate(_statefulSplashTaskProvider);
              }

              // Retry failed one-time tasks
              if (oneTimeSplashTask.hasError) {
                ref.invalidate(_statelessSplashTaskProvider);
              }
            }
          : null,
    );
  }

  /// Determines whether splash screen should be displayed based on task states.
  ///
  /// This method implements the logic for when to show splash vs main app.
  /// The key insight is that splash should only be triggered by:
  /// 1. Initial loading of any task type
  /// 2. Watch phase changes in reactive tasks (when showSplashWhenDependencyChanged is true)
  /// 
  /// Execute phase changes in reactive tasks should NOT trigger splash display.
  bool _shouldShowSplash({
    required SplashConfig config,
    required AsyncValue<bool> oneTimeTask,
    required AsyncValue<void> statefulTasks,
    required AsyncValue<Map<ReactiveSplashTask, dynamic>> reactiveWatchTask,
    required AsyncValue<void> reactiveExecuteTask,
  }) {
    // If any task hasn't completed successfully, show splash
    if (!oneTimeTask.hasValue || 
        !statefulTasks.hasValue || 
        !reactiveWatchTask.hasValue || 
        !reactiveExecuteTask.hasValue) {
      return true;
    }

    // If dependency change splash is disabled, hide splash once all tasks complete
    if (!config.showSplashWhenDependencyChanged) {
      return false;
    }

    // If dependency change splash is enabled, show splash when:
    // 1. Stateful tasks are refreshing (legacy behavior)
    // 2. Reactive watch tasks are refreshing (NEW: only watch phase triggers splash)
    // Note: Reactive execute tasks refreshing should NOT trigger splash
    if (statefulTasks.isLoading || reactiveWatchTask.isLoading) {
      return true;
    }

    return false;
  }
}
