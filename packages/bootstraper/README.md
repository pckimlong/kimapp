# Bootstraper

A comprehensive Flutter application bootstrap system that orchestrates app initialization through bootstrap tasks and splash screen management with support for one-time and reactive task execution patterns.

## Features

- **Two-Phase Initialization**: Pre-UI bootstrap tasks and post-UI splash tasks for optimal startup performance
- **Task Types**: One-time tasks that run once per app lifetime and reactive tasks with precise splash control
- **Smart Splash Management**: Show splash screens only when necessary, with configurable reactivity
- **Comprehensive Error Handling**: Robust error handling with retry mechanisms and proper cleanup
- **Provider Integration**: Deep integration with Riverpod for dependency injection and state management
- **Flexible UI**: Customizable splash screen UI with error states and retry functionality
- **Performance Optimized**: Parallel task execution and minimal overhead
- **Developer-Friendly**: Extensive logging and debugging capabilities

## Core Concepts

### Bootstrap Process Overview

The bootstrapper orchestrates a two-phase initialization:

1. **Bootstrap Phase** (pre-UI): Runs lightweight, critical tasks before any UI is displayed
2. **Splash Phase** (post-UI): Runs heavier tasks while showing splash screen to users

### Task Types

#### Bootstrap Tasks
- Execute once during application startup before any UI is displayed
- Have access to full `BootstrapContext` with environment, container, and logger
- Should be lightweight and error-resistant

#### Splash Tasks

**One-Time Tasks** (`OneTimeSplashTask`):
- Run only once per application lifetime when successful
- No dependency watching or cleanup needed
- Ideal for one-time initialization (themes, configuration)

**Reactive Tasks** (`ReactiveSplashTask`):
- Separate watch and execute phases for precise splash control
- Only providers watched in `watch()` method trigger splash re-display
- Can provide disposal callbacks for cleanup
- Ideal for user-dependent operations (auth, user data)

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  bootstraper:
    path: ../bootstraper  # Adjust path as needed
```

## Quick Start

### 1. Basic Setup

```dart
import 'package:bootstraper/bootstraper.dart';

void main() async {
  await Bootstraper.initialize(
    application: MyApp(),
    environment: IntegrationMode.development,
    logger: MyCustomLogger(), // Optional: provide your logger
    
    // Bootstrap tasks: critical, lightweight tasks before UI
    initialTasks: [
      CrashReportingBootstrapTask(),
      DatabaseBootstrapTask(),
    ],
    
    // Splash configuration: tasks that run with UI feedback
    splashConfig: SplashConfig(
      tasks: [
        // One-time: run once per app lifetime when successful
        ThemeInitializationTask(),
        ConfigurationLoadTask(),
        
        // Reactive: precise control over splash triggers
        UserAuthenticationTask(),
        UserDataLoadTask(),
      ],
      pageBuilder: (error, retry) {
        if (error != null) {
          return ErrorSplashPage(error: error, onRetry: retry);
        }
        return LoadingSplashPage();
      },
    ),
  );
}
```

### 2. App Widget Setup

**CRITICAL**: The `SplashBuilder` must be used in the `builder` property of your app:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      // CRITICAL: SplashBuilder MUST be in the builder function
      builder: (context, child) => SplashBuilder(child: child!),
      home: HomePage(),
    );
  }
}
```

## Creating Tasks

### Bootstrap Task Example

```dart
class DatabaseBootstrapTask extends BootstrapTask {
  @override
  Future<void> execute(BootstrapContext context) async {
    context.logger.info('Initializing database...');
    
    final database = context.container.read(databaseProvider);
    await database.initialize();
    
    context.logger.info('Database initialized successfully');
  }
}
```

### One-Time Splash Task Example

```dart
class ThemeInitializationTask extends OneTimeSplashTask {
  @override
  Future<DisposalCallback?> execute(SplashContext context) async {
    final themeService = context.ref.read(themeServiceProvider);
    await themeService.loadUserPreferences();
    
    // This runs only once per app lifetime when successful
    return null; // No cleanup needed
  }
}
```

### Reactive Splash Task Example

```dart
class UserDataTask extends ReactiveSplashTask<User?, DisposalCallback?> {
  @override
  Future<User?> watch(Ref ref) async {
    // Only user provider changes trigger splash re-display
    return ref.watch(userProvider);
  }

  @override
  Future<DisposalCallback?> execute(SplashContext context, User? user) async {
    if (user == null) return null;
    
    // Can access any providers without triggering splash
    final preferences = context.ref.read(userPreferencesProvider);
    final analytics = context.ref.watch(analyticsProvider);
    
    await setupUserEnvironment(user, preferences, analytics);
    
    // Return cleanup callback
    return () => cleanupUserEnvironment();
  }
}
```

## Advanced Configuration

### Splash Screen with Reactivity

```dart
SplashConfig(
  tasks: [
    UserAuthenticationTask(),
    UserDataLoadTask(),
  ],
  // Show splash again when auth state changes
  showSplashWhenDependencyChanged: true,
  // Ensure splash is visible for at least 2 seconds
  minimumDuration: Duration(seconds: 2),
  
  pageBuilder: (error, retry) {
    if (error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 48),
              SizedBox(height: 16),
              Text('Failed to load app: $error'),
              SizedBox(height: 16),
              if (retry != null)
                ElevatedButton(
                  onPressed: retry,
                  child: Text('Retry'),
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading...'),
          ],
        ),
      ),
    );
  },
)
```

### Provider Overrides and Observers

```dart
await Bootstraper.initialize(
  application: MyApp(),
  environment: IntegrationMode.development,
  
  // Provider overrides for testing or environment-specific config
  providerOverrides: [
    apiUrlProvider.overrideWithValue('https://api.example.com'),
    loggerProvider.overrideWithValue(MyCustomLogger()),
  ],
  
  // Observers for debugging and monitoring
  providerObservers: [
    LoggingProviderObserver(),
  ],
  
  // Early initialization of critical providers
  earlyEagerInitializer: (ref) {
    ref.read(criticalServiceProvider);
  },
);
```

## Complex Reactive Task Examples

### Multi-Value Watch with Records

```dart
class UserTask extends ReactiveSplashTask<(User?, AuthState), DisposalCallback?> {
  @override
  Future<(User?, AuthState)> watch(Ref ref) async {
    // Both user and auth changes trigger splash
    final user = ref.watch(userProvider);
    final authState = ref.watch(authStateProvider);
    return (user, authState);
  }

  @override
  Future<DisposalCallback?> execute(SplashContext context, (User?, AuthState) data) async {
    final (user, authState) = data;
    
    final preferences = context.ref.read(userPreferencesProvider);
    await syncUserData(user, authState, preferences);
    
    return null;
  }
}
```

### Async Watch Operations

```dart
class ConfigTask extends ReactiveSplashTask<AppConfig, DisposalCallback?> {
  @override
  Future<AppConfig> watch(Ref ref) async {
    final environment = ref.watch(environmentProvider);
    
    // Async operation in watch phase
    final remoteConfig = await ref.watch(remoteConfigProvider.future);
    final localConfig = ref.watch(localConfigProvider);
    
    return AppConfig.merge(environment, remoteConfig, localConfig);
  }

  @override
  Future<DisposalCallback?> execute(SplashContext context, AppConfig config) async {
    final logger = context.ref.read(loggerProvider);
    await initializeWithConfig(config, logger);
    return null;
  }
}
```

## Error Handling Best Practices

1. **Always Handle Errors**: Check for `error != null` in splash page builder
2. **Provide Retry Option**: Use the `retry` callback when available
3. **User-Friendly Messages**: Show meaningful error descriptions
4. **Graceful Degradation**: Consider allowing users to skip failed tasks
5. **Proper Cleanup**: Use disposal callbacks for resource management

## Logging and Debugging

### Custom Logger Implementation

```dart
class MyLogger extends Logger {
  @override
  void info(String message, {Object? object, StackTrace? stackTrace}) {
    print('[INFO] $message');
    if (object != null) print('  Object: $object');
  }
  
  @override
  void error(String message, {required Object? error, required StackTrace? stackTrace}) {
    print('[ERROR] $message');
    if (error != null) print('  Error: $error');
    if (stackTrace != null) print('  Stack: $stackTrace');
  }
  
  // Implement other methods...
}
```

### Accessing Logger in Tasks

```dart
// In Bootstrap Tasks
class MyBootstrapTask extends BootstrapTask {
  @override
  Future<void> execute(BootstrapContext context) async {
    context.logger.info('Task started');
    // ... task logic
  }
}

// In Widgets
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = ref.logger;
    logger.debug('Widget built');
    return Container();
  }
}
```

## Performance Considerations

- **Task Ordering**: Put critical tasks first, optional tasks last
- **Minimum Duration**: Use sparingly to avoid perceived slowness
- **Dependency Reactivity**: Only enable when necessary for your use case
- **Error Recovery**: Fast retry mechanisms improve user experience
- **Resource Management**: Always provide disposal callbacks for cleanup

## Testing

### Mocking in Tests

```dart
final container = ProviderContainer(
  overrides: [
    loggerProvider.overrideWithValue(MockLogger()),
    _splashConfigProvider.overrideWithValue(testSplashConfig),
  ],
);

// Test your bootstrap tasks
final task = MyBootstrapTask();
final context = BootstrapContext(
  env: IntegrationMode.test,
  container: container,
  logger: container.read(loggerProvider),
);

await task.execute(context);
```

## Migration Guide

### From Previous Versions

If you're upgrading from an earlier version:

1. **Task Types**: Update task inheritance to use `OneTimeSplashTask` or `ReactiveSplashTask`
2. **Splash Builder**: Ensure `SplashBuilder` is in your app's `builder` property
3. **Provider Integration**: Update provider access patterns to use the new extensions

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Bootstrap      │───▶│  Flutter App    │───▶│  Splash System  │
│  Tasks          │    │  Launch         │    │  Tasks          │
│  (Pre-UI)       │    │                 │    │  (Post-UI)      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
        │                        │                        │
        ▼                        ▼                        ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Environment    │    │  Provider       │    │  Main App       │
│  Setup          │    │  Container      │    │  UI             │
│  Error Handling │    │  Error Handling │    │  Display        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Contributing

When contributing to this package:

1. Follow the existing code patterns and documentation style
2. Add comprehensive tests for new features
3. Update documentation for any API changes
4. Use the provided CLAUDE.md for development guidance

## License

This package is licensed under the same license as the parent project.