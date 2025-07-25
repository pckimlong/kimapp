# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the `bootstraper` package, a Flutter package that provides a comprehensive application bootstrap system. It orchestrates app initialization through bootstrap tasks and splash screen management with support for one-time and reactive task execution patterns.

## Development Commands

### Flutter Package Commands
```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .

# Check for lint issues
flutter analyze
```

### Dependency Management
```bash
# Get dependencies
flutter pub get

# Clean build cache
flutter clean && flutter pub get
```

## Architecture

### Core Bootstrap System

The package centers around the `Bootstraper` class which orchestrates a two-phase initialization:

1. **Bootstrap Phase** (pre-UI): Runs lightweight, critical tasks before any UI is displayed
2. **Splash Phase** (post-UI): Runs heavier tasks while showing splash screen to users

### Key Components

#### Bootstrap Tasks (`BootstrapTask`)
- Execute once before UI starts
- Have access to `BootstrapContext` (environment, container, logger)
- Should be lightweight and error-resistant
- Located in `lib/src/bootstrap_task.dart`

#### Splash Tasks (`SplashTask`)
Two distinct types with different execution behaviors:

**One-Time Tasks** (`OneTimeSplashTask`):
- Run only once per application lifetime when successful
- No dependency watching or cleanup needed
- Ideal for one-time initialization (themes, config)

**Reactive Tasks** (`ReactiveSplashTask`):
- Separate watch and execute phases for precise splash control
- Only providers watched in `watch()` method trigger splash re-display
- Can provide disposal callbacks for cleanup
- Ideal for user-dependent operations (auth, user data)

#### Splash Configuration (`SplashConfig`)
- Defines splash UI via `pageBuilder` function
- Manages task execution and error handling
- Controls minimum duration and reactive behavior
- Located in `lib/src/splash_config.dart`

### Provider Integration

The package integrates deeply with Riverpod:
- Creates `ProviderContainer` with overrides and observers
- Provides `SplashContext` with `Ref` for splash tasks
- Supports early eager initialization of providers
- Automatic splash task provider management in `lib/src/splash_task_provider.dart`

### Error Handling

Comprehensive error handling across multiple layers:
- `PlatformDispatcher.onError` for platform-level errors
- `FlutterError.onError` for framework errors
- `runZonedGuarded` for async errors
- Task-specific error logging and recovery

### Dependencies

- **kimapp_utils**: Provides logging and startup utilities
- **hooks_riverpod**: Dependency injection and state management
- **flutter**: Core Flutter framework

## Code Patterns

### Task Implementation
```dart
// Bootstrap task
class MyBootstrapTask extends BootstrapTask {
  @override
  Future<void> execute(BootstrapContext context) async {
    // Access environment: context.env
    // Access container: context.container
    // Access logger: context.logger
  }
}

// One-time splash task (runs once)
class MyOneTimeTask extends OneTimeSplashTask {
  @override
  Future<DisposalCallback?> execute(SplashContext context) async {
    // Use context.ref to access providers
    return null;
  }
}

// Reactive splash task (precise splash control)
class MyReactiveTask extends ReactiveSplashTask<String?, DisposalCallback?> {
  @override
  Future<String?> watch(Ref ref) async {
    // Only providers watched here trigger splash
    return ref.watch(someProvider);
  }

  @override
  Future<DisposalCallback?> execute(SplashContext context, String? data) async {
    // Can access any providers without triggering splash
    return null;
  }
}
```

### Initialization Pattern
```dart
await Bootstraper.initialize(
  application: MyApp(),
  environment: IntegrationMode.development,
  logger: MyLogger(),
  initialTasks: [/* bootstrap tasks */],
  splashConfig: SplashConfig(
    tasks: [/* splash tasks */],
    pageBuilder: (error, retry) => MySplashPage(error, retry),
  ),
  providerOverrides: [/* provider overrides */],
);
```

## File Structure

- `lib/bootstraper.dart` - Main export file
- `lib/src/bootstrap.dart` - Main bootstrap orchestration and imports
- `lib/src/bootstraper.dart` - Core Bootstraper class implementation
- `lib/src/bootstrap_task.dart` - Task base classes and context objects
- `lib/src/splash_config.dart` - Splash configuration and documentation
- `lib/src/splash_task_provider.dart` - Riverpod integration for splash tasks
- `lib/src/splash_builder.dart` - UI builder for splash screens
- `lib/src/logger.dart` - Logger provider integration

## Key Concepts

### Task Execution Lifecycle
1. Bootstrap tasks run in parallel before UI
2. Flutter app launches with provider scope
3. Splash system initializes with one-time and reactive task providers
4. One-time tasks run once and cache results
5. Reactive tasks run reactively based on dependencies
6. Disposal callbacks handle cleanup when needed

### Reactive Splash Behavior
When `showSplashWhenDependencyChanged` is enabled, reactive tasks that watch providers in their `watch()` method will trigger splash re-display when dependencies change, enabling seamless state transitions.