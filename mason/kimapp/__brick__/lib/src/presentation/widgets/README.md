# Shared Widgets

This directory contains all reusable UI components used throughout the BookTrade application. The widgets are organized into categorical folders to maintain a clean and scalable architecture.

## Directory Structure

```
widgets/
├── README.md                    # This documentation file
├── app_widgets.dart             # Common widget utilities and extensions
├── buttons/                     # Button components
├── components/                  # Miscellaneous UI components
├── dialogs/                     # Modal dialogs and popups
├── feedback/                    # Loading, error, and status indicators
├── forms/                       # Form fields and input controls
├── layouts/                     # Layout containers and structural components
├── lists/                       # List items and list containers
├── navigation/                  # Navigation components (app bars, tabs, etc.)
├── theme/                       # Theme-related components and utilities
└── typography/                  # Text and typography components
```

## Usage Guidelines

### Importing Widgets

Import widgets directly from their source files:

```dart
import 'package:book_swap/src/presentation/widgets/buttons/app_button.dart';
import 'package:book_swap/src/presentation/widgets/feedback/app_toast.dart';
```

Direct imports improve Dart analyzer performance and make dependencies more explicit.

### Creating New Widgets

1. **Determine the appropriate category** for your widget
2. **Create a new file** in the corresponding directory
3. **Follow naming conventions**:
   - Use descriptive names that indicate the widget's purpose
   - Suffix with `Widget` for clarity (e.g., `CustomButtonWidget`)

### Styling Guidelines

All widgets should:

1. **Use the app's design system** from `app_style.dart` (AS class)
2. **Leverage context extensions** from `build_context_helper.dart`:
   ```dart
   // Example usage
   context.theme       // Access the current ThemeData
   context.colors      // Access the current ColorScheme
   context.textTheme   // Access the current TextTheme
   ```

3. **Support theming** by using theme-based colors rather than hardcoded values
4. **Be responsive and adaptive** to work across different screen sizes

### Widget Documentation

When creating a new widget, include:

1. **Class-level documentation**:
   ```dart
   /// A custom button with predefined styling based on the app theme.
   /// 
   /// Used for primary actions throughout the app.
   class CustomButtonWidget extends StatelessWidget {
     // ...
   }
   ```

2. **Property documentation**:
   ```dart
   /// The text displayed inside the button.
   final String label;
   
   /// Optional icon to display before the label.
   final IconData? icon;
   ```

## Widget Categories

### Buttons
Button components with consistent styling, including primary, secondary, text buttons, and icon buttons.

### Components
General UI components that don't fit into other categories, such as cards, dividers, and custom displays.

### Dialogs
Modal components for confirmations, alerts, and other popup interfaces.

### Feedback
Components that provide user feedback, such as loaders, progress indicators, and status messages.

### Forms
Input fields, form containers, and validation components used in data entry screens.

### Layouts
Structural components like scaffolds, containers, and layout utilities.

### Lists
List items, grid items, and list containers used for displaying collections of data.

### Navigation
Navigation components like app bars, bottom navigation, drawer items, and tabs.

### Theme
Theme-related components and utilities for managing the app's appearance.

### Typography
Text components with consistent styling based on the app's text theme. 