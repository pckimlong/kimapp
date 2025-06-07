part of 'bootstrap.dart';

/// Provider for the application logger.
///
/// This provider supplies a [Logger] instance that is used throughout the
/// bootstrap system for logging initialization steps, errors, and other
/// important events.
///
/// **Important**: This provider controls logging for the entire application.
/// Since all logging throughout the app goes through this single provider,
/// the logger instance you provide here (or don't provide) will determine
/// the logging behavior for the entire system.
///
/// ## Default Behavior
///
/// By default, this provider returns an [_EmptyLogger] that does nothing,
/// effectively disabling the entire application's logging system. This means:
///
/// - All log calls throughout the app will have zero overhead
/// - No log output will be produced anywhere in the application
/// - Bootstrap tasks, widgets, and providers will all use the empty logger
/// - The app remains fully functional but silent regarding logging
///
/// This is safe for production environments where you might not want any
/// logging overhead or output.
///
/// ## ⚠️ System-Wide Logging Impact
///
/// **Critical Note**: If you do not provide a custom logger, logging is
/// completely disabled throughout your entire application. This means:
///
/// - Bootstrap tasks won't log their progress or errors
/// - Widget lifecycle and interaction logging will be silent
/// - Provider initialization and state change logging will be silent
/// - Error logging during app initialization will be silent
/// - All `ref.logger` and `context.logger` calls will do nothing
///
/// While the app will continue to function normally, you'll lose all
/// visibility into what's happening during bootstrap and runtime.
/// Consider providing at least a minimal logger implementation for
/// development and debugging purposes.
///
/// ## Customizing the Logger
///
/// You can provide a custom logger implementation in several ways:
///
/// ### 1. Through the Bootstraper.initialize() method:
///
/// ```dart
/// await Bootstraper.initialize(
///   application: MyApp(),
///   environment: IntegrationMode.development,
///   logger: MyCustomLogger(),
///   // ... other parameters
/// );
/// ```
///
/// ### 2. Through provider overrides:
///
/// ```dart
/// await Bootstraper.initialize(
///   application: MyApp(),
///   environment: IntegrationMode.development,
///   providerOverrides: [
///     loggerProvider.overrideWithValue(MyCustomLogger()),
///   ],
///   // ... other parameters
/// );
/// ```
///
/// ### 3. In tests:
///
/// ```dart
/// final container = ProviderContainer(
///   overrides: [
///     loggerProvider.overrideWithValue(MockLogger()),
///   ],
/// );
/// ```
///
/// ## Logger Interface
///
/// The logger must implement the [Logger] abstract class from `kimapp_utils`,
/// which provides methods for different log levels:
/// - `debug()`: For debug information
/// - `info()`: For general information
/// - `warning()`: For warnings
/// - `error()`: For errors (requires error object and stack trace)
///
/// ## Usage in Bootstrap Tasks
///
/// Bootstrap tasks can access the logger through the [BootstrapContext]:
///
/// ```dart
/// class MyBootstrapTask extends BootstrapTask {
///   @override
///   Future<void> execute(BootstrapContext context) async {
///     context.logger.info('Starting my bootstrap task');
///
///     try {
///       // Do some work
///       context.logger.debug('Task completed successfully');
///     } catch (error, stackTrace) {
///       context.logger.error(
///         'Task failed',
///         error: error,
///         stackTrace: stackTrace,
///       );
///       rethrow;
///     }
///   }
/// }
/// ```
///
/// ## Usage in Widgets
///
/// Widgets can access the logger through the provided extensions:
///
/// ```dart
/// class MyWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final logger = ref.logger;
///     logger.info('Widget built');
///
///     return Container();
///   }
/// }
/// ```
///
/// See also:
/// - [Logger] abstract class for the logger interface
/// - [BootstrapContext] for accessing the logger in bootstrap tasks
/// - [LoggerRefAccess] for accessing the logger from providers
/// - [LoggerWidgetRefAccess] for accessing the logger from widgets
final loggerProvider = Provider<Logger>((ref) {
  return _EmptyLogger();
});

/// Extension on [Ref] to provide easy access to the logger.
///
/// This extension allows any provider that has access to a [Ref] to easily
/// get the logger instance. This is particularly useful for providers that
/// need to log information during their initialization or execution.
///
/// ## Usage Example
///
/// ```dart
/// final myServiceProvider = Provider<MyService>((ref) {
///   final logger = ref.logger;
///   logger.info('Initializing MyService');
///
///   return MyService();
/// });
///
/// final myFutureProvider = FutureProvider<String>((ref) async {
///   final logger = ref.logger;
///   logger.debug('Starting async operation');
///
///   try {
///     final result = await someAsyncOperation();
///     logger.info('Async operation completed successfully');
///     return result;
///   } catch (error, stackTrace) {
///     logger.error(
///       'Async operation failed',
///       error: error,
///       stackTrace: stackTrace,
///     );
///     rethrow;
///   }
/// });
/// ```
extension LoggerRefAccess on Ref {
  Logger get logger => read(loggerProvider);
}

/// Extension on [WidgetRef] to provide easy access to the logger.
///
/// This extension allows any widget that has access to a [WidgetRef] to easily
/// get the logger instance. This is particularly useful for widgets that need
/// to log user interactions, widget lifecycle events, or error conditions.
///
/// ## Usage Examples
///
/// ### In ConsumerWidget
///
/// ```dart
/// class MyWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final logger = ref.logger;
///     logger.debug('MyWidget build called');
///
///     return ElevatedButton(
///       onPressed: () {
///         logger.info('Button pressed');
///         // Handle button press
///       },
///       child: Text('Press me'),
///     );
///   }
/// }
/// ```
///
/// ### In Consumer
///
/// ```dart
/// Consumer(
///   builder: (context, ref, child) {
///     final logger = ref.logger;
///     final data = ref.watch(someProvider);
///
///     logger.debug('Consumer rebuilt with data: $data');
///
///     return Text(data.toString());
///   },
/// )
/// ```
///
/// ### Error Handling in Widgets
///
/// ```dart
/// class ErrorProneWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     try {
///       final data = ref.watch(someProvider);
///       return Text(data.toString());
///     } catch (error, stackTrace) {
///       ref.logger.error(
///         'Widget build failed',
///         error: error,
///         stackTrace: stackTrace,
///       );
///       return ErrorWidget(error);
///     }
///   }
/// }
/// ```
extension LoggerWidgetRefAccess on WidgetRef {
  Logger get logger => read(loggerProvider);
}

/// An empty logger implementation that does nothing.
///
/// This is the default logger used by the bootstrap system when no custom
/// logger is provided. It implements all methods of the [Logger] interface
/// but performs no actual logging operations.
///
/// ## Purpose
///
/// The empty logger serves several purposes:
///
/// 1. **Safe Default**: Provides a safe default that won't cause errors
///    if no logging implementation is configured.
///
/// 2. **Performance**: Has zero overhead since all methods are no-ops,
///    making it suitable for production environments where logging might
///    not be desired.
///
/// 3. **Testing**: Can be used in tests where logging output is not needed
///    and might clutter test output.
///
/// ## When to Use
///
/// The empty logger is automatically used when:
/// - No custom logger is provided to `Bootstraper.initialize()`
/// - No logger override is specified in `providerOverrides`
/// - You explicitly want to disable logging across the entire application
///
/// **Important**: When the empty logger is active, the entire application's
/// logging system is disabled. This affects:
/// - All bootstrap tasks and their logging calls
/// - All widget logging through the extension methods
/// - All provider logging through the extension methods
/// - Any custom code that uses the logger from the provider
///
/// The application will function normally, but no logging output will be
/// produced anywhere in the system.
///
/// ## Replacing with Custom Logger
///
/// To replace the empty logger with a functional one:
///
/// ```dart
/// // Option 1: Through Bootstraper.initialize()
/// await Bootstraper.initialize(
///   application: MyApp(),
///   environment: IntegrationMode.development,
///   logger: ConsoleLogger(), // Your custom logger
/// );
///
/// // Option 2: Through provider overrides
/// await Bootstraper.initialize(
///   application: MyApp(),
///   environment: IntegrationMode.development,
///   providerOverrides: [
///     loggerProvider.overrideWithValue(FileLogger()),
///   ],
/// );
/// ```
///
/// ## Implementation Details
///
/// All logger methods are implemented as empty functions:
/// - No side effects anywhere in the application
/// - No exceptions thrown
/// - No performance impact
/// - Parameters are ignored but still type-checked
/// - **All logging calls throughout the entire app become no-ops**
///
/// This ensures that code calling logger methods will continue to work
/// whether using the empty logger or a real implementation. However,
/// it also means that your entire application becomes "silent" from
/// a logging perspective when this logger is active.
class _EmptyLogger extends Logger {
  /// Does nothing. Debug messages are ignored.
  @override
  void debug(String message, {Object? object, StackTrace? stackTrace}) {}

  /// Does nothing. Error messages are ignored.
  @override
  void error(String message, {required Object? error, required StackTrace? stackTrace}) {}

  /// Does nothing. Info messages are ignored.
  @override
  void info(String message, {Object? object, StackTrace? stackTrace}) {}

  /// Does nothing. Warning messages are ignored.
  @override
  void warning(String message, {Object? object, StackTrace? stackTrace}) {}

  @override
  void addListener(LogListener listener) {
    debugPrint(
      'Adding listener to empty logger, but it will not be called. '
      'This logger does not support listeners.',
    );
  }

  @override
  void clearListeners() {}

  @override
  void removeListener(LogListener listener) {}
}
