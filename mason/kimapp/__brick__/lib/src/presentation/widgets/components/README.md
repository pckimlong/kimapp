# Components Directory

This directory contains custom widgets that don't fit into other specialized categories like buttons, forms, or feedback.

## Purpose

The components directory is for:

- Custom widgets that combine multiple Flutter widgets to create new functionality
- Specialized widgets that don't belong in other categories
- Utility widgets that enhance the UI but aren't tied to a specific UI category

## Guidelines

When adding new components to this directory:

1. Ensure the component doesn't fit better in one of the specialized directories
2. Follow the naming convention: `app_[component_name].dart`
3. Extend `AppBaseWidget` when appropriate for consistent theming
4. Add exports to `index.dart` and `app_widgets.dart`
5. Document the component with proper dartdoc comments

## Current Components

- `app_skeleton.dart` - A skeleton loading component for content loading states
- `app_version_widget.dart` - A widget to display the app version
- `async_value_prod_widget.dart` - A widget to handle async values in production
- `multi_list_selection_divider.dart` - A divider for multi-list selections 