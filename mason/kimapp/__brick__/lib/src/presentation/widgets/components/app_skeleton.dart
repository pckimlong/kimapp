import 'package:flutter/material.dart';

import '../theme/base_widget.dart';

/// A skeleton loading component that can be used to indicate loading state
/// for content that is being fetched.
class AppSkeleton extends AppBaseWidget {
  const AppSkeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 4.0,
    this.margin,
    this.shimmerEnabled = true,
    this.shimmerDuration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
    this.child,
  });

  /// The height of the skeleton
  final double? height;

  /// The width of the skeleton
  final double? width;

  /// The border radius of the skeleton
  final double borderRadius;

  /// The margin around the skeleton
  final EdgeInsetsGeometry? margin;

  /// Whether to enable the shimmer effect
  final bool shimmerEnabled;

  /// The duration of the shimmer animation
  final Duration shimmerDuration;

  /// The base color of the skeleton
  final Color? baseColor;

  /// The highlight color of the shimmer effect
  final Color? highlightColor;

  /// Optional child widget to display inside the skeleton
  final Widget? child;

  /// Creates a circular skeleton
  factory AppSkeleton.circular({
    Key? key,
    required double size,
    EdgeInsetsGeometry? margin,
    bool shimmerEnabled = true,
    Duration shimmerDuration = const Duration(milliseconds: 1500),
    Color? baseColor,
    Color? highlightColor,
    Widget? child,
  }) {
    return AppSkeleton(
      key: key,
      height: size,
      width: size,
      borderRadius: size / 2,
      margin: margin,
      shimmerEnabled: shimmerEnabled,
      shimmerDuration: shimmerDuration,
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }

  /// Creates a text line skeleton
  factory AppSkeleton.text({
    Key? key,
    double? width,
    double height = 16.0,
    EdgeInsetsGeometry? margin,
    bool shimmerEnabled = true,
    Duration shimmerDuration = const Duration(milliseconds: 1500),
    Color? baseColor,
    Color? highlightColor,
  }) {
    return AppSkeleton(
      key: key,
      height: height,
      width: width,
      margin: margin,
      shimmerEnabled: shimmerEnabled,
      shimmerDuration: shimmerDuration,
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }

  /// Creates a rectangular skeleton for images
  factory AppSkeleton.image({
    Key? key,
    required double width,
    required double height,
    double borderRadius = 8.0,
    EdgeInsetsGeometry? margin,
    bool shimmerEnabled = true,
    Duration shimmerDuration = const Duration(milliseconds: 1500),
    Color? baseColor,
    Color? highlightColor,
    Widget? child,
  }) {
    return AppSkeleton(
      key: key,
      height: height,
      width: width,
      borderRadius: borderRadius,
      margin: margin,
      shimmerEnabled: shimmerEnabled,
      shimmerDuration: shimmerDuration,
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }

  @override
  Widget buildWithTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Determine colors
    final actualBaseColor = baseColor ?? colors.surfaceContainerHighest;
    final actualHighlightColor = highlightColor ?? colors.surface;

    Widget skeleton = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: actualBaseColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );

    // Apply shimmer effect if enabled
    if (shimmerEnabled) {
      skeleton = _ShimmerEffect(
        duration: shimmerDuration,
        baseColor: actualBaseColor,
        highlightColor: actualHighlightColor,
        child: skeleton,
      );
    }

    // Apply margin if provided
    if (margin != null) {
      skeleton = Padding(
        padding: margin!,
        child: skeleton,
      );
    }

    return skeleton;
  }
}

/// A widget that applies a shimmer effect to its child
class _ShimmerEffect extends StatefulWidget {
  const _ShimmerEffect({
    required this.child,
    required this.duration,
    required this.baseColor,
    required this.highlightColor,
  });

  final Widget child;
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(
                _animation.value,
                0.0,
              ),
              end: Alignment(
                _animation.value + 1,
                0.0,
              ),
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// A widget that displays a list of skeleton items
class AppSkeletonList extends AppBaseWidget {
  const AppSkeletonList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollable = true,
    this.padding,
    this.separatorBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  });

  /// The number of skeleton items to display
  final int itemCount;

  /// Builder function for creating skeleton items
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// Whether the list should be scrollable
  final bool scrollable;

  /// Padding around the list
  final EdgeInsetsGeometry? padding;

  /// Builder function for creating separators between items
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// The scroll direction of the list
  final Axis scrollDirection;

  /// Whether the list should shrink wrap its contents
  final bool shrinkWrap;

  /// The physics of the scrollable widget
  final ScrollPhysics? physics;

  @override
  Widget buildWithTheme(BuildContext context) {
    final listView = separatorBuilder != null
        ? ListView.separated(
            padding: padding,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder!,
            scrollDirection: scrollDirection,
            shrinkWrap: shrinkWrap,
            physics: scrollable ? physics : const NeverScrollableScrollPhysics(),
          )
        : ListView.builder(
            padding: padding,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            scrollDirection: scrollDirection,
            shrinkWrap: shrinkWrap,
            physics: scrollable ? physics : const NeverScrollableScrollPhysics(),
          );

    return listView;
  }
}
