// TEMPLATE FILE - Copy this file when creating a new widget
// Delete this comment line and rename the class and file appropriately
//
// NOTE: Before using this template, update the imports below based on your project structure
// The current imports are commented out to avoid linter errors in the template itself

import 'package:flutter/material.dart';
// Uncomment and adjust these imports as needed for your widget:
// import 'package:book_swap/src/core/helpers/build_context_helper.dart';
// import 'package:book_swap/src/presentation/app/app_style.dart';

/// A brief description of what this widget does.
///
/// Include use cases, examples, or any important considerations.
class TemplateWidget extends StatelessWidget {
  /// Create a new instance of [TemplateWidget].
  ///
  /// [label] is required and represents the main text content.
  /// [onTap] is optional and is called when the widget is tapped.
  const TemplateWidget({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
  });

  /// The main text to display.
  final String label;

  /// Optional callback when the widget is tapped.
  final VoidCallback? onTap;

  /// Optional icon to display alongside the text.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    // Use Theme.of(context) directly or context extensions when imports are set up
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    // TODO: When AS class is imported, use predefined spacing constants:
    // Example: AS.wGap8 instead of SizedBox(width: 8)

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: colors.primary),
              const SizedBox(width: 8, height: 0), // Replace with AS.wGap8
            ],
            Expanded(
              child: Text(
                label,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
