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
///     logger: MyCustomLogger(),
///
///     // Bootstrap tasks: Run once before UI, lightweight and critical
///     initialTasks: [
///       DatabaseBootstrapTask(),        // Initialize database connection
///       ConfigurationBootstrapTask(),   // Load essential config
///       CrashReportingBootstrapTask(),  // Set up error reporting
///     ],
///
///     splashConfig: SplashConfig(
///       tasks: [
///         // Stateless tasks: Run once per app lifetime when successful
///         ThemeInitializationTask(),    // Load theme once per app lifetime
///         LocalizationTask(),          // Set up i18n once per app lifetime
///
///         // Stateful tasks: May run multiple times based on state changes
///         UserDataSplashTask(),        // Re-runs when auth state changes
///         NotificationSetupTask(),     // Re-runs when user/settings change
///       ],
///       pageBuilder: (error, retry) => MySplashPage(error, retry),
///     ),
///     providerOverrides: [
///       // Override providers for testing or different environments
///       apiUrlProvider.overrideWithValue('https://api.example.com'),
///       // Logger can also be overridden here instead of using the logger parameter
///       loggerProvider.overrideWithValue(MyCustomLogger()),
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
/// ### Bootstrap Tasks
/// - Run before the app UI starts, should be lightweight and critical
/// - Execute once during application startup before any UI is displayed
/// - Have access to full BootstrapContext with environment, container, and logger
/// - Should be error-resistant and not block app startup
///
/// ### Splash Tasks
/// - Run after UI starts, can be heavier and show progress to users
/// - Have different execution behaviors based on their type:
///   - **One-Time Tasks**: Run only once per application lifetime when successful
///   - **Reactive Tasks**: Separate watch and execute phases for precise splash control
/// - Have access to SplashContext with Riverpod Ref for provider interaction
/// - Can provide visual feedback through splash screen UI
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
  /// - [logger]: Optional logger instance to use throughout the bootstrap process.
  ///   If not provided, an empty logger that does nothing will be used.
  ///   You can also override the logger through [providerOverrides] by overriding
  ///   the [loggerProvider].
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
  ///   logger: MyCustomLogger(),
  ///
  ///   // Bootstrap tasks: Run once before UI starts
  ///   initialTasks: [
  ///     CrashReportingBootstrapTask(),  // Critical error reporting setup
  ///     BasicConfigBootstrapTask(),     // Essential configuration
  ///   ],
  ///
  ///   splashConfig: SplashConfig(
  ///     tasks: [
  ///       // Stateless: Run once per app lifetime when successful
  ///       ThemeTask(),                  // Theme setup once per app lifetime
  ///
  ///       // Stateful: May run multiple times based on dependency changes
  ///       AuthTask(),                   // Re-runs when auth state changes
  ///     ],
  ///     pageBuilder: (error, retry) => SplashPage(error, retry),
  ///   ),
  ///   ),
  /// );
  /// ```
  ///
  /// Throws: Any critical errors during initialization that cannot be handled gracefully.
  static Future<void> initialize({
    required Widget application,
    required IntegrationMode environment,
    required Logger? logger,

    /// Tasks which run in main, these should be all the tasks which are lightweight, none
    /// error prone and should not block the app from starting.
    List<BootstrapTask> initialTasks = const [],
    SplashConfig? splashConfig,
    List providerOverrides = const [],
    List<ProviderObserver> providerObservers = const [],
    void Function(WidgetRef ref)? earlyEagerInitializer,
  }) async {
    IntegrationMode.setMode(environment);

    final container = _createProviderContainer(
      splashConfig,
      providerOverrides,
      providerObservers,
      logger,
    );

    final context = _buildBootstrapContext(environment, container);

    // Set up global error handling for the platform dispatcher
    // This will catch errors that occur outside the Flutter framework
    // such as in the Dart VM or during platform channel communication
    // This is critical to ensure we log any uncaught errors that might
    // otherwise crash the app without proper logging
    // This should be set before any Flutter binding is initialized
    // to ensure it catches all errors from the start
    PlatformDispatcher.instance.onError = (error, stack) {
      context.logger.error('PlatformDispatcher caught error', error: error, stackTrace: stack);
      return false;
    };

    await runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await Future.wait(initialTasks.map((task) => _executeTaskWithLogging(task, context)));

        // Handle flutter framework errors
        // This will catch errors in the widget tree and log them
        FlutterError.onError = (details) {
          context.logger.error(
            'Flutter framework error',
            error: details.exception,
            stackTrace: details.stack,
          );
        };

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
        if (error is _BootstrapTaskError) {
          // This error is already logged in the task execution method
          return;
        }

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
  /// The logger is retrieved from the provider container using the [loggerProvider].
  /// If a logger was passed to the initialize method, it will override the default
  /// logger provider. Otherwise, an empty logger that does nothing will be used.
  ///
  /// Parameters:
  /// - [env]: The integration mode for this app instance
  /// - [container]: The configured provider container
  ///
  /// Returns: A configured [BootstrapContext] for bootstrap tasks
  static BootstrapContext _buildBootstrapContext(IntegrationMode env, ProviderContainer container) {
    return BootstrapContext(env: env, container: container, logger: container.read(loggerProvider));
  }

  /// Creates and configures the Riverpod provider container.
  ///
  /// This internal method sets up the dependency injection container that will
  /// be used throughout the application. It:
  /// 1. Applies any provided provider overrides for testing or configuration
  /// 2. Sets up the splash configuration if provided
  /// 3. Registers any provider observers for debugging or monitoring
  /// 4. Overrides the logger provider if a custom logger was provided
  ///
  /// The splash configuration is automatically injected into the container
  /// as an override of the internal `_splashConfigProvider`, making it
  /// available to the splash system.
  ///
  /// The logger, if provided, overrides the default [loggerProvider] to ensure
  /// the custom logger is used throughout the bootstrap process.
  ///
  /// Parameters:
  /// - [splashConfig]: Optional splash system configuration
  /// - [providerOverrides]: Provider overrides for testing or environment config
  /// - [providerObservers]: Observers for monitoring provider state changes
  /// - [logger]: Optional custom logger instance to use
  ///
  /// Returns: A configured [ProviderContainer] ready for use
  static ProviderContainer _createProviderContainer(
    SplashConfig? splashConfig,
    List providerOverrides,
    List<ProviderObserver> providerObservers,
    Logger? logger,
  ) {
    return ProviderContainer(
      overrides: [
        ...providerOverrides,
        if (splashConfig != null) _splashConfigProvider.overrideWithValue(splashConfig),
        if (logger != null) loggerProvider.overrideWithValue(logger),
      ],
      observers: providerObservers,
    );
  }

  /// Execute a single task with comprehensive logging
  static Future<void> _executeTaskWithLogging(BootstrapTask task, BootstrapContext context) async {
    final taskName = task.runtimeType.toString();
    final startTime = DateTime.now();

    context.logger.info('🚀 Starting bootstrap task: $taskName');

    try {
      await task.execute(context);
      final duration = DateTime.now().difference(startTime);

      context.logger.info('✅ Completed bootstrap task: $taskName in ${duration.inMilliseconds}ms');
    } catch (error, stackTrace) {
      final duration = DateTime.now().difference(startTime);

      context.logger.error(
        '❌ Failed bootstrap task: $taskName after ${duration.inMilliseconds}ms',
        error: error,
        stackTrace: stackTrace,
      );

      throw _BootstrapTaskError();
    }
  }
}

/// An error that indicates a failure in executing a bootstrap task.
/// This used to signal zone guarded errors no need to log them again
/// since it already logged in the `_executeTaskWithLogging` method.
class _BootstrapTaskError {
  const _BootstrapTaskError();
}
