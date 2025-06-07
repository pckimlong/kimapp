part of 'bootstrap.dart';

/// A callback function type used for cleanup operations.
///
/// This typedef represents a function that can be called to dispose of resources,
/// cancel subscriptions, or perform other cleanup tasks when a splash task completes.
typedef DisposalCallback = VoidCallback;

/// Context object that provides essential dependencies for bootstrap tasks.
///
/// This class encapsulates the core dependencies needed during the application
/// bootstrap phase, including environment configuration, dependency injection
/// container, and logging capabilities.
///
/// Example usage:
/// ```dart
/// class MyBootstrapTask extends BootstrapTask {
///   @override
///   Future<void> execute(BootstrapContext context) async {
///     context.logger.info('Starting bootstrap task...');
///     final service = context.container.read(myServiceProvider);
///     // Perform bootstrap operations
///   }
/// }
/// ```
class BootstrapContext {
  /// The current integration mode/environment (e.g., development, staging, production).
  final IntegrationMode env;

  /// The dependency injection container for accessing providers and services.
  final ProviderContainer container;

  /// Logger instance for recording bootstrap events and debugging information.
  final Logger logger;

  /// Creates a new [BootstrapContext] with the required dependencies.
  ///
  /// All parameters are required as they represent essential components
  /// needed for proper application initialization.
  BootstrapContext({required this.container, required this.env, required this.logger});
}

/// Context object that provides access to Riverpod's dependency injection system
/// during splash screen operations.
///
/// This lightweight context is specifically designed for splash tasks that need
/// to access providers and perform operations while the splash screen is visible.
/// It provides a [Ref] object which can be used to read providers, watch for
/// state changes, and interact with the application's state management system.
///
/// Example usage:
/// ```dart
/// class DataLoadingSplashTask extends StatelessSplashTask {
///   @override
///   Future<void> execute(SplashContext context) async {
///     final dataService = context.ref.read(dataServiceProvider);
///     await dataService.preloadCriticalData();
///   }
/// }
/// ```
class SplashContext {
  /// The Riverpod reference object for accessing providers and state.
  ///
  /// This [Ref] can be used to:
  /// - Read provider values with `ref.read(provider)`
  /// - Watch for changes with `ref.watch(provider)`
  /// - Listen to providers with `ref.listen(provider, callback)`
  final Ref ref;

  /// Creates a new [SplashContext] with the provided [Ref].
  SplashContext(this.ref);
}


/// Abstract base class for tasks that run during application bootstrap.
///
/// Bootstrap tasks are executed once during the application startup process,
/// before the main UI is displayed. These tasks typically handle critical
/// initialization operations such as:
/// - Setting up logging and crash reporting
/// - Initializing databases and storage
/// - Configuring network clients
/// - Loading essential configuration
/// - Setting up authentication
///
/// Bootstrap tasks have access to the full [BootstrapContext] which provides
/// environment information, dependency injection container, and logging capabilities.
///
/// Example implementation:
/// ```dart
/// class DatabaseBootstrapTask extends BootstrapTask {
///   @override
///   Future<void> execute(BootstrapContext context) async {
///     context.logger.info('Initializing database...');
///     final database = context.container.read(databaseProvider);
///     await database.initialize();
///     context.logger.info('Database initialized successfully');
///   }
/// }
/// ```
///
/// See also:
/// - [SplashTask] for tasks that run during splash screen display
/// - [BootstrapContext] for available dependencies during bootstrap
abstract class BootstrapTask {
  /// Executes the bootstrap task with the provided context.
  ///
  /// This method should contain all the initialization logic for this specific
  /// bootstrap task. It will be called once during application startup.
  ///
  /// The [context] parameter provides access to:
  /// - Environment configuration via `context.env`
  /// - Dependency injection container via `context.container`
  /// - Logger instance via `context.logger`
  ///
  /// Throws any exceptions that occur during execution. The bootstrap system
  /// may handle these exceptions according to its error handling strategy.
  Future<void> execute(BootstrapContext context);
}

/// Abstract base class for tasks that run during splash screen display.
///
/// Splash tasks execute while the splash screen is visible to the user, and have
/// different execution behaviors based on their type:
///
/// ## Execution Behavior Differences
///
/// - **Stateless Tasks**: Run only once per application lifetime if successful.
///   Once completed successfully, they will not run again until app restart.
///
/// - **Stateful Tasks**: May run multiple times based on dependency changes.
///   Use `context.ref.watch()` to make tasks reactive to state changes.
///
/// Splash tasks are typically used for operations that:
/// - Load initial application data
/// - Perform authentication checks
/// - Prefetch critical resources
/// - Initialize user-specific services
/// - Prepare the initial application state
///
/// Unlike [BootstrapTask]s which run once during app startup before UI,
/// splash tasks run after the UI starts and can provide visual feedback
/// to users through the splash screen.
///
/// The generic type [Result] represents the return type of the task execution.
/// Use `void` for tasks that don't return a value, or a specific type for
/// tasks that produce results needed by other parts of the application.
///
/// Example implementations:
/// ```dart
/// // Task that loads user profile data
/// class UserProfileSplashTask extends SplashTask<UserProfile> {
///   @override
///   Future<UserProfile> execute(SplashContext context) async {
///     final userService = context.ref.read(userServiceProvider);
///     return await userService.getCurrentUserProfile();
///   }
/// }
///
/// // Task that performs setup without returning data
/// class CacheWarmupSplashTask extends SplashTask<void> {
///   @override
///   Future<void> execute(SplashContext context) async {
///     final cacheService = context.ref.read(cacheServiceProvider);
///     await cacheService.warmupCriticalData();
///   }
/// }
/// ```
///
/// See also:
/// - [StatelessSplashTask] for one-time execution tasks
/// - [StatefulSplashTask] for tasks that may need cleanup
/// - [SplashContext] for available dependencies during splash execution
abstract class SplashTask<Result> {
  /// Executes the splash task and returns a result of type [Result].
  ///
  /// This method contains the main logic of the splash task and will be called
  /// when the splash screen is displayed. The [context] parameter provides
  /// access to the Riverpod dependency injection system through `context.ref`.
  ///
  /// The returned [Future] should complete when the task is finished. The
  /// result can be used by the splash system or other components as needed.
  ///
  /// Throws any exceptions that occur during execution. The splash system
  /// should handle these exceptions gracefully, potentially showing error
  /// states or fallback UI.
  Future<Result> execute(SplashContext context);
}

/// A reactive splash task that separates dependency watching from task execution.
///
/// This class addresses the issue where any `ref.watch()` call in a task execution
/// would trigger splash screen re-display, even when the dependency change shouldn't
/// interrupt the user experience.
///
/// ## Key Features
///
/// 1. **Separate Watch Phase**: Define which providers trigger splash display in [watch]
/// 2. **Smart Splash Control**: [SplashBuilder] controls splash display based on provider states
/// 3. **Async Watch Support**: The [watch] method can perform async operations
/// 4. **Type-Safe Data Passing**: Watched data is passed to execution with full type safety
///
/// ## How It Works
///
/// 1. **Watch Phase**: [watch] defines what providers to monitor for changes
///    - Only changes to providers watched here will trigger splash screen re-display
///    - Can perform async operations to determine watch data
///    - Supports complex data structures and multiple providers
///
/// 2. **Execute Phase**: [execute] performs the actual task work
///    - Receives watched data as a parameter
///    - Can watch any additional providers freely
///    - Splash control is handled by [SplashBuilder] checking provider refresh/reload states
///
/// ## Example Implementations
///
/// ### Simple Single-Value Watch
/// ```dart
/// class ThemeTask extends ReactiveSplashTask<ThemeMode, DisposalCallback?> {
///   @override
///   Future<ThemeMode> watch(Ref ref) async {
///     return ref.watch(themeModeProvider); // Only theme changes trigger splash
///   }
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, ThemeMode themeMode) async {
///     // Can access other providers freely
///     final locale = context.ref.read(localeProvider);
///     final settings = context.ref.watch(settingsProvider);
///     
///     await applyTheme(themeMode, locale, settings);
///     return null;
///   }
/// }
/// ```
///
/// ### Multi-Value Watch with Records
/// ```dart
/// class UserTask extends ReactiveSplashTask<(User?, AuthState), DisposalCallback?> {
///   @override
///   Future<(User?, AuthState)> watch(Ref ref) async {
///     // Both user and auth changes trigger splash
///     final user = ref.watch(userProvider);
///     final authState = ref.watch(authStateProvider);
///     return (user, authState);
///   }
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, (User?, AuthState) data) async {
///     final (user, authState) = data;
///     
///     // Can access any providers needed
///     final preferences = context.ref.read(userPreferencesProvider);
///     final analytics = context.ref.watch(analyticsProvider);
///     
///     await syncUserData(user, authState, preferences, analytics);
///     return null;
///   }
/// }
/// ```
///
/// ### Complex Data Structure
/// ```dart
/// class UserWatchData {
///   final User? user;
///   final AuthState authState;
///   final List<Permission> permissions;
///   
///   UserWatchData({required this.user, required this.authState, required this.permissions});
/// }
///
/// class ComplexUserTask extends ReactiveSplashTask<UserWatchData, DisposalCallback?> {
///   @override
///   Future<UserWatchData> watch(Ref ref) async {
///     final user = ref.watch(userProvider);
///     final authState = ref.watch(authStateProvider);
///     
///     // Can perform async operations in watch
///     final permissions = authState.isAuthenticated 
///         ? await ref.watch(userPermissionsProvider.future)
///         : <Permission>[];
///     
///     return UserWatchData(
///       user: user,
///       authState: authState, 
///       permissions: permissions,
///     );
///   }
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, UserWatchData data) async {
///     // Complex logic with strongly typed data
///     final cache = context.ref.read(cacheProvider);
///     final analytics = context.ref.watch(analyticsProvider);
///     
///     await setupUserEnvironment(data, cache, analytics);
///     return () => cleanupUserEnvironment();
///   }
/// }
/// ```
///
/// ### Async Watch Operations
/// ```dart
/// class ConfigTask extends ReactiveSplashTask<AppConfig, DisposalCallback?> {
///   @override
///   Future<AppConfig> watch(Ref ref) async {
///     final environment = ref.watch(environmentProvider);
///     
///     // Async operation in watch phase
///     final remoteConfig = await ref.watch(remoteConfigProvider.future);
///     final localConfig = ref.watch(localConfigProvider);
///     
///     return AppConfig.merge(environment, remoteConfig, localConfig);
///   }
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, AppConfig config) async {
///     final logger = context.ref.read(loggerProvider);
///     
///     await initializeWithConfig(config, logger);
///     return null;
///   }
/// }
/// ```
///
/// ## Benefits Over Traditional StatefulSplashTask
///
/// 1. **Precise Control**: Only specific provider changes trigger splash
/// 2. **Better UX**: Prevent unnecessary splash displays
/// 3. **Clear Separation**: Watch intent is explicit and separate from execution
/// 4. **Type Safety**: Compile-time verification of data flow
/// 5. **Async Support**: Can perform async operations during watch phase
/// 6. **Performance**: Avoid unnecessary re-execution for unrelated changes
///
/// ## Migration from StatefulSplashTask
///
/// ```dart
/// // Old approach - any ref.watch triggers splash
/// class OldUserTask extends StatefulSplashTask {
///   @override
///   Future<DisposalCallback?> execute(SplashContext context) async {
///     final user = context.ref.watch(userProvider);        // Triggers splash
///     final theme = context.ref.watch(themeProvider);      // Also triggers splash!
///     await processUser(user, theme);
///     return null;
///   }
/// }
///
/// // New approach - explicit control over splash triggers  
/// class NewUserTask extends ReactiveSplashTask<User?, DisposalCallback?> {
///   @override
///   Future<User?> watch(Ref ref) async {
///     return ref.watch(userProvider); // Only user changes trigger splash
///   }
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, User? user) async {
///     final theme = context.ref.read(themeProvider); // SplashBuilder handles splash logic
///     await processUser(user, theme);
///     return null;
///   }
/// }
/// ```
///
/// See also:
/// - [SplashTask] for basic non-reactive tasks
/// - [StatelessSplashTask] for one-time execution tasks  
/// - [StatefulSplashTask] for backward-compatible reactive tasks
/// - [SplashContext] for provider access during execution
abstract class ReactiveSplashTask<WatchData, Result> {
  /// Define which providers to watch and return the data needed for execution.
  ///
  /// This method is called during the watch phase to determine:
  /// 1. Which provider changes should trigger splash screen display
  /// 2. What data should be passed to the [execute] method
  ///
  /// ## Key Behaviors
  ///
  /// - **Splash Triggers**: Only providers watched in this method will cause
  ///   the splash screen to reappear when they change
  /// - **Async Support**: This method can perform async operations, allowing
  ///   you to await provider futures or perform complex data preparation
  /// - **Data Preparation**: The returned data is passed to [execute], enabling
  ///   type-safe data flow between watch and execution phases
  /// - **Multiple Providers**: Can watch multiple providers and combine their
  ///   values into a single data structure
  ///
  /// ## Examples
  ///
  /// ### Single Provider Watch
  /// ```dart
  /// @override
  /// Future<User?> watch(Ref ref) async {
  ///   return ref.watch(userProvider);
  /// }
  /// ```
  ///
  /// ### Multiple Providers with Records
  /// ```dart
  /// @override
  /// Future<(User?, String)> watch(Ref ref) async {
  ///   final user = ref.watch(userProvider);
  ///   final theme = ref.watch(themeProvider);
  ///   return (user, theme);
  /// }
  /// ```
  ///
  /// ### Async Data Preparation
  /// ```dart
  /// @override
  /// Future<UserData> watch(Ref ref) async {
  ///   final user = ref.watch(userProvider);
  ///   final permissions = await ref.watch(permissionsProvider.future);
  ///   return UserData(user: user, permissions: permissions);
  /// }
  /// ```
  ///
  /// ## Error Handling
  ///
  /// If this method throws an exception, the splash system will:
  /// 1. Show the error in the splash screen
  /// 2. Provide a retry mechanism
  /// 3. Allow the user to recover from the error
  ///
  /// ## Performance Notes
  ///
  /// - This method is called reactively when watched providers change
  /// - Keep async operations lightweight to avoid blocking the splash display
  /// - Consider caching expensive computations when possible
  ///
  /// Returns the watched data to be passed to [execute]. The data type is
  /// defined by the [WatchData] generic parameter.
  Future<WatchData> watch(Ref ref);

  /// Execute the task using the watched data and return a result.
  ///
  /// This method performs the actual task logic using:
  /// 1. **Watched Data**: Data from the [watch] method passed as [watchedData]
  /// 2. **Additional Providers**: Access via [context.ref] for any additional data
  ///
  /// ## Key Behaviors
  ///
  /// - **Full Provider Access**: Can use `context.ref.watch()`, `context.ref.read()`, etc.
  /// - **Type-Safe Data**: The [watchedData] parameter provides compile-time
  ///   type safety for the data flow from watch to execution
  /// - **Splash Control**: Splash display behavior is controlled by [SplashBuilder]
  ///   based on provider refresh/reload states, not by what you watch here
  /// - **Resource Management**: Can return disposal callbacks for cleanup
  ///
  /// ## Examples
  ///
  /// ### Using Watched Data with Additional Providers
  /// ```dart
  /// @override
  /// Future<DisposalCallback?> execute(SplashContext context, User? user) async {
  ///   // Use watched data
  ///   if (user == null) return null;
  ///   
  ///   // Access additional providers freely
  ///   final settings = context.ref.read(settingsProvider);
  ///   final theme = context.ref.watch(themeProvider);
  ///   
  ///   await setupUserSession(user, settings, theme);
  ///   return () => cleanupUserSession();
  /// }
  /// ```
  ///
  /// ### Complex Data Processing
  /// ```dart
  /// @override
  /// Future<UserConfig> execute(SplashContext context, (User?, AuthState) data) async {
  ///   final (user, authState) = data;
  ///   
  ///   final cache = context.ref.read(cacheProvider);
  ///   final database = context.ref.watch(databaseProvider);
  ///   
  ///   return await buildUserConfig(user, authState, cache, database);
  /// }
  /// ```
  ///
  /// ## Error Handling
  ///
  /// If this method throws an exception:
  /// 1. The error is displayed in the splash screen
  /// 2. Any previously returned disposal callbacks are called for cleanup
  /// 3. A retry mechanism is provided to the user
  /// 4. On retry, both [watch] and [execute] are called again
  ///
  /// ## Resource Management
  ///
  /// Return a [DisposalCallback] if your task creates resources that need cleanup:
  /// - Network connections or subscriptions
  /// - Timers or periodic tasks  
  /// - File handles or database connections
  /// - Background services
  ///
  /// The disposal callback will be called when:
  /// - The task is re-executed due to dependency changes
  /// - The application is put in background for extended periods
  /// - The user logs out or switches accounts
  /// - The application is being terminated
  ///
  /// ## Performance Notes
  ///
  /// - This method runs after the watch phase completes
  /// - Can perform heavier operations since watched data is already available
  /// - Can watch any providers needed for execution
  ///
  /// Parameters:
  /// - [context]: Provides full access to the Riverpod system
  /// - [watchedData]: Type-safe data from the [watch] method
  ///
  /// Returns a result of type [Result], typically [DisposalCallback?] for
  /// splash tasks that may need cleanup.
  Future<Result> execute(SplashContext context, WatchData watchedData);
}

/// A splash task that executes once per application lifetime if successful.
///
/// **Key Execution Behavior**: One-time tasks run only once per application lifetime
/// when successful. If they fail, they can be retried, but once they complete successfully,
/// they will not run again until the application is restarted.
///
/// This is a convenience class for splash tasks that:
/// - Don't return any meaningful result (return type is `void`)
/// - Don't need to be re-executed during the application lifecycle
/// - Don't create resources that require cleanup
/// - Perform one-time initialization that should persist for the app lifetime
///
/// Use this class for simple, one-time operations during splash screen display
/// such as:
/// - Loading static configuration
/// - Performing one-time setup operations
/// - Prefetching non-critical data
/// - Initializing third-party SDKs
/// - Setting up global app state that doesn't change
///
/// Example implementation:
/// ```dart
/// class ThemeInitializationTask extends OneTimeSplashTask {
///   @override
///   Future<void> execute(SplashContext context) async {
///     final themeService = context.ref.read(themeServiceProvider);
///     await themeService.loadUserPreferences();
///     // This will run only once per app lifetime when successful
///   }
/// }
/// ```
///
/// For tasks that need to run multiple times based on dependency changes,
/// use [ReactiveSplashTask] instead.
abstract class OneTimeSplashTask extends SplashTask<DisposalCallback?> {}

/// @Deprecated('Use OneTimeSplashTask instead. StatelessSplashTask will be removed in a future version.')
/// Legacy alias for OneTimeSplashTask. Use [OneTimeSplashTask] for new code.
@Deprecated('Use OneTimeSplashTask instead. StatelessSplashTask will be removed in a future version.')
typedef StatelessSplashTask = OneTimeSplashTask;

/// @Deprecated('Use ReactiveSplashTask instead. StatefulSplashTask will be removed in a future version.')
/// Legacy splash task with less precise splash control.
///
/// **DEPRECATED**: This class is deprecated in favor of [ReactiveSplashTask] which provides
/// better control over when splash screens are displayed. [StatefulSplashTask] causes
/// splash re-display for ANY `ref.watch()` call, which can lead to poor user experience.
///
/// **Migration Guide**:
/// ```dart
/// // Old approach - any ref.watch triggers splash
/// class OldUserTask extends StatefulSplashTask {
///   @override
///   Future<DisposalCallback?> execute(SplashContext context) async {
///     final user = context.ref.watch(userProvider);        // Triggers splash
///     final theme = context.ref.watch(themeProvider);      // Also triggers splash!
///     await processUser(user, theme);
///     return null;
///   }
/// }
///
/// // New approach - explicit control over splash triggers  
/// class NewUserTask extends ReactiveSplashTask<User?, DisposalCallback?> {
///   @override
///   Future<User?> watch(Ref ref) async {
///     return ref.watch(userProvider); // Only user changes trigger splash
///   }
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, User? user) async {
///     final theme = context.ref.watch(themeProvider); // Won't trigger unwanted splash
///     await processUser(user, theme);
///     return null;
///   }
/// }
/// ```
///
/// **Why Deprecated**:
/// - ❌ ANY `ref.watch()` call triggers splash screen re-display
/// - ❌ Poor user experience when watching auxiliary providers  
/// - ❌ No separation between splash triggers and data access
/// - ❌ Difficult to control when splash should actually appear
///
/// **Use [ReactiveSplashTask] Instead**:
/// - ✅ Precise control over splash triggers via separate `watch()` method
/// - ✅ Better user experience - only intended changes show splash
/// - ✅ Type-safe data flow from watch to execute phase
/// - ✅ Can access any providers in execute without splash side effects
///
/// See also:
/// - [ReactiveSplashTask] for the recommended reactive task approach
/// - [OneTimeSplashTask] for simple one-time tasks
@Deprecated('Use ReactiveSplashTask instead. StatefulSplashTask will be removed in a future version.')
abstract class StatefulSplashTask extends SplashTask<DisposalCallback?> {}

// ============================================================================
// Convenience Type Aliases for Common Reactive Task Patterns
// ============================================================================

/// Convenience typedef for reactive splash tasks that return disposal callbacks.
///
/// This is the most common pattern for reactive splash tasks that need cleanup.
/// Use this when your task watches for provider changes and may need to dispose
/// of resources when re-executing.
///
/// Example:
/// ```dart
/// class UserDataTask extends ReactiveTask<User?> {
///   @override
///   Future<User?> watch(Ref ref) async => ref.watch(userProvider);
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, User? user) async {
///     // Setup user environment
///     return () => cleanupUserEnvironment();
///   }
/// }
/// ```
typedef ReactiveTask<WatchData> = ReactiveSplashTask<WatchData, DisposalCallback?>;

/// Convenience typedef for reactive splash tasks that return data results.
///
/// Use this when your reactive task needs to return processed data rather than
/// just performing side effects.
///
/// Example:
/// ```dart
/// class ConfigProcessorTask extends ReactiveDataTask<AppConfig, ProcessedConfig> {
///   @override
///   Future<AppConfig> watch(Ref ref) async => ref.watch(configProvider);
///   
///   @override
///   Future<ProcessedConfig> execute(SplashContext context, AppConfig config) async {
///     final additionalData = context.ref.read(additionalProvider);
///     return ProcessedConfig.from(config, additionalData);
///   }
/// }
/// ```
typedef ReactiveDataTask<WatchData, Result> = ReactiveSplashTask<WatchData, Result>;

/// Convenience typedef for simple reactive tasks that watch a single provider.
///
/// This is a shorthand for the most common pattern where you watch one provider
/// and perform some action based on its value.
///
/// Example:
/// ```dart
/// class SimpleUserTask extends SimpleReactiveTask<User?> {
///   @override
///   Future<User?> watch(Ref ref) async => ref.watch(userProvider);
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, User? user) async {
///     await handleUserChange(user);
///     return null;
///   }
/// }
/// ```
typedef SimpleReactiveTask<T> = ReactiveSplashTask<T, DisposalCallback?>;

/// Convenience typedef for reactive tasks that watch multiple values using records.
///
/// This makes it easier to work with multiple watched providers using Dart 3.0 records.
///
/// Example:
/// ```dart
/// class MultiWatchTask extends MultiReactiveTask<User?, AuthState> {
///   @override
///   Future<(User?, AuthState)> watch(Ref ref) async {
///     return (ref.watch(userProvider), ref.watch(authProvider));
///   }
///   
///   @override
///   Future<DisposalCallback?> execute(SplashContext context, (User?, AuthState) data) async {
///     final (user, auth) = data;
///     await syncUserAuth(user, auth);
///     return null;
///   }
/// }
/// ```
typedef MultiReactiveTask<T1, T2> = ReactiveSplashTask<(T1, T2), DisposalCallback?>;

/// Convenience typedef for reactive tasks that watch three values using records.
typedef TripleReactiveTask<T1, T2, T3> = ReactiveSplashTask<(T1, T2, T3), DisposalCallback?>;

/// Convenience typedef for reactive tasks that watch four values using records.
typedef QuadReactiveTask<T1, T2, T3, T4> = ReactiveSplashTask<(T1, T2, T3, T4), DisposalCallback?>;
