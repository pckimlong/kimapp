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
/// Splash tasks execute while the splash screen is visible to the user, typically
/// used for operations that:
/// - Load initial application data
/// - Perform authentication checks
/// - Prefetch critical resources
/// - Initialize user-specific services
/// - Prepare the initial application state
///
/// Unlike [BootstrapTask]s which run once during app startup, splash tasks
/// may be re-executed in certain scenarios (e.g., when returning to the app
/// after a long period of inactivity).
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

/// A splash task that executes once and doesn't require cleanup.
///
/// This is a convenience class for splash tasks that:
/// - Don't return any meaningful result (return type is `void`)
/// - Don't need to be re-executed during the application lifecycle
/// - Don't create resources that require cleanup
///
/// Use this class for simple, one-time operations during splash screen display
/// such as:
/// - Loading static configuration
/// - Performing one-time setup operations
/// - Prefetching non-critical data
/// - Initializing third-party SDKs
///
/// Example implementation:
/// ```dart
/// class ThemeInitializationTask extends StatelessSplashTask {
///   @override
///   Future<void> execute(SplashContext context) async {
///     final themeService = context.ref.read(themeServiceProvider);
///     await themeService.loadUserPreferences();
///   }
/// }
/// ```
///
/// For tasks that need cleanup or return values, consider using [StatefulSplashTask]
/// or the base [SplashTask] class directly.
abstract class StatelessSplashTask extends SplashTask<void> {}

/// A splash task that may be re-executed and can provide cleanup functionality.
///
/// This class is designed for splash tasks that:
/// - May need to run multiple times during the application lifecycle
/// - Create resources, subscriptions, or listeners that need cleanup
/// - Return a disposal callback for resource management
/// - React to dependency changes and re-execute automatically
///
/// The task returns a [DisposalCallback] (or `null` if no cleanup is needed)
/// which will be called when:
/// - The application is backgrounded for an extended period
/// - The user logs out or switches accounts
/// - The splash system determines cleanup is necessary
/// - The application is being terminated
/// - Dependencies change and the task needs to re-execute
///
/// ## Reactive Behavior with `watch`
///
/// StatefulSplashTask is designed to work with `context.ref.watch()` for reactive
/// behavior. When you watch a provider that changes (like auth state, user settings,
/// etc.), the splash screen will be shown again and the task will re-execute.
/// This is particularly useful for scenarios like:
/// - Authentication state changes requiring data refresh
/// - User switching accounts
/// - Theme or locale changes
/// - Network connectivity changes
///
/// Use this class for operations that:
/// - Establish network connections or subscriptions
/// - Start background services or timers
/// - Create temporary files or caches
/// - Initialize stateful components
/// - React to auth state or other dependency changes
///
/// Example implementation:
/// ```dart
/// class RealtimeDataSplashTask extends StatefulSplashTask {
///   StreamSubscription? _subscription;
///
///   @override
///   Future<DisposalCallback?> execute(SplashContext context) async {
///     final dataService = context.ref.read(realtimeDataServiceProvider);
///
///     // Start listening to real-time updates
///     _subscription = dataService.dataStream.listen((data) {
///       // Handle real-time data updates
///     });
///
///     // Return cleanup callback
///     return () {
///       _subscription?.cancel();
///       _subscription = null;
///     };
///   }
/// }
///
/// // Example with reactive behavior using watch
/// class UserDataSplashTask extends StatefulSplashTask {
///   @override
///   Future<DisposalCallback?> execute(SplashContext context) async {
///     // Watch auth state - will re-execute when user logs in/out
///     final authState = context.ref.watch(authStateProvider);
///
///     if (authState.isAuthenticated) {
///       final userService = context.ref.read(userServiceProvider);
///       await userService.loadUserSpecificData();
///
///       // Set up real-time sync for authenticated user
///       final syncService = context.ref.read(syncServiceProvider);
///       syncService.startSync();
///
///       return () => syncService.stopSync();
///     }
///
///     // No cleanup needed for unauthenticated state
///     return null;
///   }
/// }
/// ```
///
/// **Note:** It's absolutely fine to return `null` from the execute method if your
/// task doesn't create any resources that need cleanup. This is common for tasks
/// that only read data or perform simple initialization without creating subscriptions
/// or background processes.
///
/// See also:
/// - [StatelessSplashTask] for simple one-time tasks
/// - [DisposalCallback] for the cleanup function signature
abstract class StatefulSplashTask extends SplashTask<DisposalCallback?> {}
