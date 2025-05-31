part of 'bootstrap.dart';

/// Internal provider for passing splash configuration through the widget tree.
///
/// This provider is automatically overridden by the [Bootstraper] when a
/// [SplashConfig] is provided during initialization. It defaults to `null`
/// when no splash configuration is specified.
///
/// **Note**: This is an internal implementation detail and should not be
/// used directly. Use [SplashConfig] through the [Bootstraper.initialize]
/// method instead.
final _splashConfigProvider = Provider<SplashConfig?>((ref) => null);

/// Configuration class for the splash screen system.
///
/// [SplashConfig] defines how the splash screen behaves, what tasks run during
/// the splash phase, and how the splash UI is constructed. This configuration
/// is passed to [Bootstraper.initialize] and controls the entire splash experience.
///
/// ## Core Responsibilities
///
/// 1. **UI Construction**: Defines how splash screens are built via [pageBuilder]
/// 2. **Task Management**: Specifies which tasks run during splash display
/// 3. **Timing Control**: Sets minimum splash duration and reactivity behavior
/// 4. **Error Handling**: Provides error states and retry mechanisms
///
/// ## Splash Screen States
///
/// The splash system can display different UIs based on task execution state:
/// - **Loading**: Tasks are running normally
/// - **Error**: One or more tasks failed with an error
/// - **Retry**: User initiated a retry after an error
///
/// ## Task Execution Model
///
/// Tasks run in a specific order and have different characteristics:
/// 1. **Stateless Tasks**: Execute once, no dependencies, no cleanup
/// 2. **Stateful Tasks**: May re-execute when dependencies change, can provide cleanup
///
/// ## Basic Usage Example
///
/// ```dart
/// SplashConfig(
///   tasks: [
///     // Stateless tasks - run once
///     ThemeInitializationTask(),
///     ConfigurationLoadTask(),
///
///     // Stateful tasks - reactive to dependencies
///     AuthenticationTask(),
///     UserDataLoadTask(),
///   ],
///   pageBuilder: (error, retry) {
///     if (error != null) {
///       return ErrorSplashPage(
///         error: error,
///         onRetry: retry,
///       );
///     }
///     return LoadingSplashPage();
///   },
/// )
/// ```
///
/// ## Advanced Configuration Example
///
/// ```dart
/// SplashConfig(
///   tasks: [
///     CacheWarmupTask(),
///     UserProfileTask(),
///     NotificationSetupTask(),
///   ],
///   // Ensure splash is visible for at least 2 seconds
///   minimumDuration: Duration(seconds: 2),
///
///   // Show splash again when auth state changes
///   showSplashWhenDependencyChanged: true,
///
///   pageBuilder: (error, retry) {
///     if (error != null) {
///       return Scaffold(
///         body: Center(
///           child: Column(
///             mainAxisAlignment: MainAxisAlignment.center,
///             children: [
///               Icon(Icons.error, color: Colors.red, size: 48),
///               SizedBox(height: 16),
///               Text('Failed to load app: $error'),
///               SizedBox(height: 16),
///               if (retry != null)
///                 ElevatedButton(
///                   onPressed: retry,
///                   child: Text('Retry'),
///                 ),
///             ],
///           ),
///         ),
///       );
///     }
///
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             CircularProgressIndicator(),
///             SizedBox(height: 16),
///             Text('Loading...'),
///           ],
///         ),
///       ),
///     );
///   },
/// )
/// ```
///
/// ## Integration with Bootstraper
///
/// ```dart
/// void main() async {
///   await Bootstraper.initialize(
///     application: MyApp(),
///     environment: IntegrationMode.development,
///     logger: (container) => Logger('MyApp'),
///
///     // Bootstrap tasks run before UI starts
///     initialTasks: [
///       CrashReportingBootstrapTask(),
///       DatabaseBootstrapTask(),
///     ],
///
///     // Splash config controls post-UI initialization
///     splashConfig: SplashConfig(
///       tasks: [
///         UserAuthenticationTask(),
///         DataPreloadTask(),
///       ],
///       pageBuilder: (error, retry) => MySplashPage(
///         error: error,
///         onRetry: retry,
///       ),
///     ),
///   );
/// }
/// ```
///
/// ## Reactive Behavior
///
/// When [showSplashWhenDependencyChanged] is `true`, the splash screen will
/// reappear whenever a [StatefulSplashTask] detects dependency changes through
/// `ref.watch()`. This is useful for scenarios like:
/// - User authentication state changes
/// - Network connectivity changes
/// - App settings or locale changes
/// - Account switching
///
/// ## Error Handling Best Practices
///
/// 1. **Always Handle Errors**: Check for `error != null` in [pageBuilder]
/// 2. **Provide Retry Option**: Use the `retry` callback when available
/// 3. **User-Friendly Messages**: Show meaningful error descriptions
/// 4. **Graceful Degradation**: Consider allowing users to skip failed tasks
///
/// ## Performance Considerations
///
/// - **Task Ordering**: Put critical tasks first, optional tasks last
/// - **Minimum Duration**: Use sparingly to avoid perceived slowness
/// - **Dependency Reactivity**: Only enable when necessary for your use case
/// - **Error Recovery**: Fast retry mechanisms improve user experience
///
/// See also:
/// - [SplashTask] for creating splash tasks
/// - [StatelessSplashTask] for simple one-time tasks
/// - [StatefulSplashTask] for reactive tasks
/// - [SplashBuilder] for integration requirements
class SplashConfig {
  /// Builder function that creates the splash screen UI.
  ///
  /// This function is called by [SplashBuilder] to construct the splash screen
  /// based on the current execution state. It receives two parameters:
  ///
  /// - [error]: The error object if any task failed, `null` during normal execution
  /// - [retry]: Callback to retry failed tasks, `null` if no retry is possible
  ///
  /// ## Implementation Guidelines
  ///
  /// ### Handle Both States
  /// Always check for error state and provide appropriate UI:
  /// ```dart
  /// pageBuilder: (error, retry) {
  ///   if (error != null) {
  ///     return ErrorSplashPage(error: error, onRetry: retry);
  ///   }
  ///   return LoadingSplashPage();
  /// }
  /// ```
  ///
  /// ### Access to Theme and Localization
  /// The splash page has full access to app theme and localization:
  /// ```dart
  /// pageBuilder: (error, retry) {
  ///   return Scaffold(
  ///     backgroundColor: Theme.of(context).primaryColor,
  ///     body: Center(
  ///       child: Text(
  ///         AppLocalizations.of(context).loading,
  ///         style: Theme.of(context).textTheme.headlineMedium,
  ///       ),
  ///     ),
  ///   );
  /// }
  /// ```
  ///
  /// ### Error Handling Best Practices
  /// - Show user-friendly error messages
  /// - Provide retry button when callback is available
  /// - Consider offering "Skip" or "Continue Offline" options
  /// - Log detailed errors for debugging while showing simple messages to users
  final Widget Function(Object? error, VoidCallback? retry) pageBuilder;

  /// Minimum duration the splash screen must be visible.
  ///
  /// This ensures the splash screen doesn't flicker for very fast tasks.
  /// Use this sparingly as it can make the app feel slower than necessary.
  ///
  /// **Default**: [Duration.zero] (no minimum duration)
  ///
  /// **Common Use Cases**:
  /// - Showing branding for a minimum time
  /// - Preventing jarring transitions for very fast loads
  /// - Meeting design requirements for splash visibility
  ///
  /// **Example**:
  /// ```dart
  /// SplashConfig(
  ///   minimumDuration: Duration(seconds: 2), // Show logo for at least 2 seconds
  ///   pageBuilder: (error, retry) => BrandingSplashPage(),
  ///   tasks: [QuickConfigTask()],
  /// )
  /// ```
  final Duration minimumDuration;

  /// List of tasks to execute during the splash phase.
  ///
  /// Tasks are executed based on their type and dependency relationships:
  ///
  /// ## Task Types
  /// - **[StatelessSplashTask]**: Run once, no cleanup, no dependencies
  /// - **[StatefulSplashTask]**: May re-run when dependencies change
  ///
  /// ## Execution Order
  /// While tasks may run concurrently where possible, dependencies are respected:
  /// ```dart
  /// tasks: [
  ///   // These might run in parallel if no dependencies
  ///   ConfigurationTask(),
  ///   ThemeTask(),
  ///
  ///   // This waits for auth state and may re-run when it changes
  ///   UserDataTask(), // Uses ref.watch(authStateProvider)
  /// ]
  /// ```
  ///
  /// ## Task Design Guidelines
  /// - Keep tasks focused on single responsibilities
  /// - Use stateless tasks for one-time initialization
  /// - Use stateful tasks for reactive behavior
  /// - Handle errors gracefully within tasks
  /// - Avoid long-running operations that block UI
  final List<SplashTask> tasks;

  /// Whether to show splash screen again when stateful task dependencies change.
  ///
  /// When `true`, the splash screen will reappear whenever a [StatefulSplashTask]
  /// detects changes in watched providers (via `ref.watch()`). This creates a
  /// reactive splash system that responds to app state changes.
  ///
  /// **Default**: `false` (splash only shows on initial app launch)
  ///
  /// ## When to Enable
  ///
  /// Enable this when you need the splash to reappear for:
  /// - **Authentication Changes**: User logs in/out
  /// - **Account Switching**: Different user data needs loading
  /// - **Network State**: Connectivity changes require data refresh
  /// - **Settings Changes**: Theme, language, or other critical settings
  ///
  /// ## Example Scenario
  ///
  /// ```dart
  /// // Task that watches auth state
  /// class UserDataTask extends StatefulSplashTask {
  ///   @override
  ///   Future<DisposalCallback?> execute(SplashContext context) async {
  ///     final authState = context.ref.watch(authStateProvider);
  ///
  ///     if (authState.isAuthenticated) {
  ///       await loadUserData();
  ///     }
  ///     return null;
  ///   }
  /// }
  ///
  /// // Config that enables reactivity
  /// SplashConfig(
  ///   showSplashWhenDependencyChanged: true, // Splash reappears on auth changes
  ///   tasks: [UserDataTask()],
  ///   pageBuilder: (error, retry) => LoadingPage(),
  /// )
  /// ```
  ///
  /// ## Performance Impact
  ///
  /// Enabling this feature:
  /// - ✅ Provides seamless state transitions
  /// - ✅ Ensures data consistency
  /// - ⚠️ May show splash more frequently
  /// - ⚠️ Can interrupt user workflows if overused
  ///
  /// **Recommendation**: Only enable when you have tasks that genuinely need
  /// to react to state changes and require splash screen display.
  final bool showSplashWhenDependencyChanged;

  /// Creates a splash configuration with the specified behavior.
  ///
  /// ## Required Parameters
  ///
  /// - [pageBuilder]: Function that builds the splash UI based on execution state
  ///
  /// ## Optional Parameters
  ///
  /// - [tasks]: List of tasks to execute during splash (defaults to empty)
  /// - [minimumDuration]: Minimum time splash must be visible (defaults to zero)
  /// - [showSplashWhenDependencyChanged]: Enable reactive splash behavior (defaults to false)
  ///
  /// ## Basic Example
  ///
  /// ```dart
  /// SplashConfig(
  ///   pageBuilder: (error, retry) {
  ///     if (error != null) {
  ///       return ErrorPage(error: error, onRetry: retry);
  ///     }
  ///     return LoadingPage();
  ///   },
  ///   tasks: [
  ///     ConfigurationTask(),
  ///     UserDataTask(),
  ///   ],
  /// )
  /// ```
  ///
  /// ## Advanced Example with Reactivity
  ///
  /// ```dart
  /// SplashConfig(
  ///   pageBuilder: (error, retry) => MySplashPage(error, retry),
  ///   tasks: [AuthReactiveTask()],
  ///   minimumDuration: Duration(milliseconds: 500),
  ///   showSplashWhenDependencyChanged: true,
  /// )
  /// ```
  const SplashConfig({
    required this.pageBuilder,
    this.tasks = const [],
    this.minimumDuration = Duration.zero,
    this.showSplashWhenDependencyChanged = false,
  });
}
