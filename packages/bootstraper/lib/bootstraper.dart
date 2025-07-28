/// A comprehensive Flutter application bootstrap system.
///
/// This library provides a powerful bootstrap system that orchestrates app initialization
/// through a two-phase process: bootstrap tasks (pre-UI) and splash tasks (post-UI).
///
/// ## Key Features
///
/// - **Two-Phase Initialization**: Pre-UI bootstrap tasks and post-UI splash tasks
/// - **Task Types**: One-time tasks and reactive tasks with precise splash control
/// - **Smart Splash Management**: Show splash screens only when necessary
/// - **Comprehensive Error Handling**: Robust error handling with retry mechanisms
/// - **Provider Integration**: Deep integration with Riverpod for dependency injection
/// - **Flexible UI**: Customizable splash screen UI with error states
/// - **Performance Optimized**: Parallel task execution and minimal overhead
///
/// ## Quick Start
///
/// ```dart
/// import 'package:bootstraper/bootstraper.dart';
///
/// void main() async {
///   await Bootstraper.initialize(
///     application: MyApp(),
///     environment: IntegrationMode.development,
///     logger: MyCustomLogger(),
///     
///     initialTasks: [
///       DatabaseBootstrapTask(),
///       CrashReportingBootstrapTask(),
///     ],
///     
///     splashConfig: SplashConfig(
///       tasks: [
///         ThemeInitializationTask(),    // OneTimeSplashTask
///         UserAuthenticationTask(),     // ReactiveSplashTask
///       ],
///       pageBuilder: (error, retry) => MySplashPage(error, retry),
///     ),
///   );
/// }
/// ```
///
/// **Important**: Your app must use `SplashBuilder` in the builder property:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) => SplashBuilder(child: child!),
///   home: HomePage(),
/// )
/// ```
///
/// ## Main Classes
///
/// - [Bootstraper]: Main bootstrap system orchestrator
/// - [BootstrapTask]: Tasks that run before UI starts
/// - [SplashTask]: Base class for splash screen tasks
/// - [OneTimeSplashTask]: Tasks that run once per app lifetime
/// - [ReactiveSplashTask]: Tasks with precise splash control
/// - [SplashConfig]: Configuration for splash screen behavior
/// - [SplashBuilder]: Widget that manages splash screen display
/// - [BootstrapContext]: Context passed to bootstrap tasks
/// - [SplashContext]: Context passed to splash tasks
///
/// See the README.md file for comprehensive documentation and examples.
library bootstraper;

export 'src/bootstrap.dart';
