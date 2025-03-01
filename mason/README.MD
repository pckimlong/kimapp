# Kimapp Template Instruction Structure

## 1. Project Architecture Overview

### Core Architecture
- **Pattern**: Feature-driven architecture with clean separation of concerns
- **State Management**: Riverpod + Flutter Hooks
- **Code Generation**: Freezed, JSON serialization, Riverpod annotation
- **Navigation**: Auto Route
- **Backend Integration**: Supabase

### Directory Structure
```
lib/
├── config.dart         # Global configuration
├── main.dart           # Production entry point
├── main_dev.dart       # Development environment entry point
├── main_stage.dart     # Staging environment entry point
└── src/
    ├── core/           # Core utilities and services
    │   ├── account/    # Authentication and user management
    │   ├── app/        # App-wide services
    │   ├── cache_manager/ # Caching functionality
    │   ├── device/     # Device-specific utilities
    │   ├── errors/     # Error handling
    │   ├── file/       # File operations
    │   └── helpers/    # Utility functions and extensions
    ├── features/       # Business logic organized by feature
    │   └── feature_name/
    │       ├── providers/ # State management
    │       ├── models/    # Data models
    │       └── schemas/   # Database schemas
    └── presentation/   # UI components
        ├── app/        # App-wide UI resources (themes, styles)
        ├── modules/    # Feature-specific UI components
        ├── router/     # Navigation configuration
        ├── startup/    # App initialization
        └── widgets/    # Reusable UI components
```

## 2. Core Development Patterns

### Schema Definition
- Use `@Schema` annotation to define database tables and models
- Define fields with types and database columns
- Generate multiple model variations (create, update, lite) from a single schema
- Run build_runner to generate code

### Repository Pattern
- Define abstract interface with `IFeatureRepo`
- Implement with Supabase or other data sources
- Use Either<Failure, Success> return types for error handling
- Provide repositories via Riverpod providers

### Provider Types
1. **Simple Action Providers**: For single actions (delete, toggle)
2. **Form Providers**: For handling form state and actions
3. **List Providers**: For paginated data fetching
4. **Detail Providers**: For single entity management

### UI Implementation
- Use generated form widgets for consistent form handling
- Implement responsive design using ResponsiveFramework
- Follow Material 3 design principles with FlexColorScheme

## 3. Styling and Theming

### Theme Configuration
- Use `AppTheme` class for light and dark theme definitions
- Based on FlexColorScheme for Material 3 support
- Configure theme properties in app_theme.dart

### Style Constants
- Use `AS` (AppStyle) class for consistent spacing and dimensions
- Predefined gaps and breakpoints for responsive design
- Follow the style configuration in app_style.dart

### Context Extensions
- Use BuildContextX extensions for theme access:
  - `context.theme` - ThemeData
  - `context.colors` - ColorScheme
  - `context.textTheme` - TextTheme
- Responsive helpers:
  - `context.isMobile`
  - `context.isTablet`
  - `context.isDesktop`
- Navigation helpers:
  - `context.pushTo()`
  - `context.replaceTo()`
  - `context.pop()`

## 4. Code Generation Rules

### File Patterns
| Pattern | Generators | Location |
|---------|------------|----------|
| `**_provider.dart` | Riverpod + Kimapp Form Generator | `features/**/providers` |
| `**_model.dart` | Freezed + JSON Serialization | `features/**/models` |
| `**_page.dart` | AutoRoute Page Generation | `presentation/modules` |
| `**_schema.dart` | Kimapp Schema Generator | `features/**/schemas` |

### Generated Code
- Run `flutter pub run build_runner build` to generate code
- Generated models will be in `*.schema.dart` files
- Generated providers will be in `*.g.dart` files

## 5. Application Initialization

### Startup Tasks
- Define startup tasks in `presentation/startup/`
- Add tasks to the startup sequence for system initialization
- Handle dependencies properly with Riverpod

### AppState Provider
- Use AppStateProvider for user-facing initialization
- Handle loading states and error handling
- Can be retriggered when needed

## 6. Best Practices

### Error Handling
- Use Either<Failure, Success> for operation results
- Implement proper error handling in repositories
- Use AsyncValueWidget for UI error states

### Form Handling
- Use @kimappForm annotation for form providers
- Implement validation in model classes
- Use generated form widgets for consistent UI

### Responsive Design
- Use ResponsiveFramework for adaptive layouts
- Follow breakpoints defined in AS class
- Implement different layouts for mobile, tablet, and desktop

### State Management
- Keep providers small and focused
- Use proper provider scoping (keepAlive when needed)
- Follow the Riverpod patterns defined in the template

## 7. Flutter UI Development Guidelines

### Design System
- Support multiple design systems (Material, Cupertino, custom)
- Use ThemeData, ColorScheme, TextTheme for consistent styling
- Follow project style config from AS class for unified design

### Context Extensions
- Use context.theme, context.textTheme from build_context_helper.dart
- Leverage utility methods for navigation and UI operations
- Follow responsive design patterns with context.isMobile, etc.

### Theming
- Support light/dark modes using proper theme inheritance
- Use FlexColorScheme for Material 3 support
- Configure theme properties in app_theme.dart

### Widget Structure
- Focus on performance and maintainability
- Keep UI code clean and organized
- Use proper widget composition for reusability

This instruction structure provides a comprehensive guide to using the kimapp template for Flutter application development, covering architecture, styling, state management, and best practices.
