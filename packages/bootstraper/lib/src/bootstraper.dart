part of 'bootstrap.dart';

/// The main bootstrap system that orchestrates application initialization.
///
/// The [Bootstraper] is responsible for setting up the entire application
/// initialization process, including:
/// - Environment configuration
/// - Dependency injection container setup
/// - Bootstrap task execution
/// - Splash screen system initialization
/// - Error handling during startup
/// - Provider system configuration
///
/// ## Bootstrap Process Overview
///
/// 1. **Environment Setup**: Sets the integration mode (development, staging, production)
/// 2. **Container Creation**: Creates the Riverpod provider container with overrides and observers
/// 3. **Bootstrap Context**: Builds the context with environment, container, and logger
/// 4. **Initial Tasks**: Executes lightweight bootstrap tasks in parallel
/// 5. **App Launch**: Starts the Flutter application with proper provider scoping
/// 6. **Splash System**: Initializes the splash task system for UI-ready operations
///
/// ## Usage Example
///
/// ```dart
/// void main() async {
///   await Bootstraper.initialize(
///     application: MyApp(),
///     environment: IntegrationMode.development,
///     logger: (container) => container.read(loggerProvider),
///     initialTasks: [
///       DatabaseBootstrapTask(),
///       ConfigurationBootstrapTask(),
///       CrashReportingBootstrapTask(),
///     ],
///     splashConfig: SplashConfig(
///       statelessTasks: [ThemeInitializationTask()],
///       statefulTasks: [UserDataSplashTask()],
///     ),
///     providerOverrides: [
///       // Override providers for testing or different environments
///       apiUrlProvider.overrideWithValue('https://api.example.com'),
///     ],
///     providerObservers: [
///       // Add logging or debugging observers
///       LoggingProviderObserver(),
///     ],
///     earlyEagerInitializer: (ref) {
///       // Initialize critical providers early
///       ref.read(criticalServiceProvider);
///     },
///   );
/// }
/// ```
///
/// ## Bootstrap vs Splash Tasks
///
/// - **Bootstrap Tasks**: Run before the app UI starts, should be lightweight and critical
/// - **Splash Tasks**: Run after UI starts, can be heavier and show progress to users
///
/// ## Error Handling
///
/// All bootstrap operations are wrapped in [runZonedGuarded] to catch and log
/// any errors that occur during initialization. This ensures the app doesn't
/// crash silently during startup.
///
/// See also:
/// - [BootstrapTask] for creating bootstrap tasks
/// - [SplashTask] for creating splash screen tasks
/// - [SplashConfig] for configuring the splash system
class Bootstraper {
  /// Initializes the application with the bootstrap system.
  ///
  /// This is the main entry point for the bootstrap system. It orchestrates
  /// the entire application initialization process from environment setup
  /// to running the Flutter application.
  ///
  /// ## Parameters
  ///
  /// ### Required Parameters
  ///
  /// - [application]: The root Flutter widget of your application
  /// - [environment]: The integration mode (development, staging, production)
  /// - [logger]: Factory function that creates a logger from the provider container
  ///
  /// ### Optional Parameters
  ///
  /// - [initialTasks]: Bootstrap tasks that run before the UI starts.
  ///   These should be lightweight, error-resistant tasks that are critical
  ///   for app startup. Examples: crash reporting setup, basic configuration.
  ///
  /// - [splashConfig]: Configuration for the splash screen system.
  ///   Defines which tasks run during splash screen display.
  ///
  /// - [providerOverrides]: Riverpod provider overrides for testing or
  ///   environment-specific configurations.
  ///
  /// - [providerObservers]: Riverpod observers for debugging, logging,
  ///   or monitoring provider state changes.
  ///
  /// - [earlyEagerInitializer]: Callback to eagerly initialize critical
  ///   providers as soon as the provider system is ready.
  ///
  /// ## Execution Flow
  ///
  /// 1. Sets the global integration mode
  /// 2. Creates the provider container with overrides and observers
  /// 3. Builds the bootstrap context with dependencies
  /// 4. Ensures Flutter widgets are initialized
  /// 5. Executes all initial bootstrap tasks in parallel
  /// 6. Launches the Flutter app with provider scoping
  /// 7. Initializes the splash task system
  /// 8. Calls early eager initializer if provided
  ///
  /// ## Error Handling
  ///
  /// All operations are wrapped in [runZonedGuarded] to catch and log
  /// any errors during initialization. Bootstrap task failures are logged
  /// but don't prevent the app from starting.
  ///
  /// ## Example
  ///
  /// ```dart
  /// await Bootstraper.initialize(
  ///   application: MyApp(),
  ///   environment: IntegrationMode.development,
  ///   logger: (container) => Logger('MyApp'),
  ///   initialTasks: [
  ///     CrashReportingBootstrapTask(),
  ///     BasicConfigBootstrapTask(),
  ///   ],
  ///   splashConfig: SplashConfig(
  ///     statelessTasks: [ThemeTask()],
  ///     statefulTasks: [AuthTask()],
  ///   ),
  /// );
  /// ```
  ///
  /// Throws: Any critical errors during initialization that cannot be handled gracefully.
  static Future<void> initialize({
    required Widget application,
    required IntegrationMode environment,
    required Logger Function(ProviderContainer container) logger,

    /// Tasks which run in main, these should be all the tasks which are lightweight, none
    /// error prone and should not block the app from starting.
    List<BootstrapTask> initialTasks = const [],
    SplashConfig? splashConfig,
    List<Override> providerOverrides = const [],
    List<ProviderObserver> providerObservers = const [],
    void Function(WidgetRef ref)? earlyEagerInitializer,
  }) async {
    IntegrationMode.setMode(environment);

    final container = _createProviderContainer(splashConfig, providerOverrides, providerObservers);

    final context = _buildBootstrapContext(environment, container, logger);

    await runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Future.wait(initialTasks.map((task) => task.execute(context)));

        runApp(
          UncontrolledProviderScope(
            container: container,
            child: Consumer(
              builder: (context, ref, child) {
                // Early eager initialization for stateless providers, and it will
                // initialize stateful providers too
                ref.watch(_statelessSplashTaskProvider);
                earlyEagerInitializer?.call(ref);

                return child!;
              },
              child: application,
            ),
          ),
        );
      },
      (error, stackTrace) {
        context.logger.error(
          'Zone caught error during app bootstrap initialization',
          error: error,
          stackTrace: stackTrace,
        );
      },
    );
  }

  /// Creates a [BootstrapContext] with the provided dependencies.
  ///
  /// This internal method constructs the context object that will be passed
  /// to all bootstrap tasks. The context provides access to:
  /// - Environment configuration
  /// - Dependency injection container
  /// - Logger instance
  ///
  /// The logger is created by calling the provided logger factory function
  /// with the container, allowing the logger to access any providers it needs.
  ///
  /// Parameters:
  /// - [env]: The integration mode for this app instance
  /// - [container]: The configured provider container
  /// - [logger]: Factory function to create the logger
  ///
  /// Returns: A configured [BootstrapContext] for bootstrap tasks
  static BootstrapContext _buildBootstrapContext(
    IntegrationMode env,
    ProviderContainer container,
    Logger Function(ProviderContainer container) logger,
  ) {
    return BootstrapContext(env: env, container: container, logger: logger(container));
  }

  /// Creates and configures the Riverpod provider container.
  ///
  /// This internal method sets up the dependency injection container that will
  /// be used throughout the application. It:
  /// 1. Applies any provided provider overrides for testing or configuration
  /// 2. Sets up the splash configuration if provided
  /// 3. Registers any provider observers for debugging or monitoring
  ///
  /// The splash configuration is automatically injected into the container
  /// as an override of the internal `_splashConfigProvider`, making it
  /// available to the splash system.
  ///
  /// Parameters:
  /// - [splashConfig]: Optional splash system configuration
  /// - [providerOverrides]: Provider overrides for testing or environment config
  /// - [providerObservers]: Observers for monitoring provider state changes
  ///
  /// Returns: A configured [ProviderContainer] ready for use
  static ProviderContainer _createProviderContainer(
    SplashConfig? splashConfig,
    List<Override> providerOverrides,
    List<ProviderObserver> providerObservers,
  ) {
    return ProviderContainer(
      overrides: [
        ...providerOverrides,
        if (splashConfig != null) _splashConfigProvider.overrideWithValue(splashConfig),
      ],
      observers: providerObservers,
    );
  }
}
