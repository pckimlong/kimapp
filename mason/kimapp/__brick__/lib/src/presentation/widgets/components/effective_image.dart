import 'package:book_swap/src/core/helpers/build_context_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';
import 'package:kimapp_utils/startup.dart';
import 'package:octo_image/octo_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EffectiveImage extends StatelessWidget {
  const EffectiveImage({
    super.key,
    required this.imageObject,
    this.getUrl,
    this.cache = true,
    this.loadingEffect = true,
    this.fit = BoxFit.cover,
    this.borderRadius = 4,
    this.width,
    this.height,
    this.imageAspectRatio,
    this.imageBuilder,
    this.errorWidget,
    this.border = true,
  });

  final bool border;
  final double? borderRadius;
  final bool cache;
  final BoxFit fit;
  final double? height;
  final bool loadingEffect;
  final BaseStorageObject? imageObject;

  /// If not provided, the image will automatically pick the best size for the given width and height
  final String Function(Size size, CompressibleImageObject image)? getUrl;
  final double? width;
  final Widget Function(BuildContext context, Widget child)? imageBuilder;
  final Widget Function(BuildContext context)? errorWidget;
  final double? imageAspectRatio;

  String _getUrlBasedOnSize(Size size) {
    if (imageObject is! CompressibleImageObject) return imageObject!.getUrl();

    final image = imageObject as CompressibleImageObject;
    final width = size.width;
    final height = size.height;

    final compressed30 = ImageDimensions.fromPath(image.getCompressed30Url());
    if (compressed30.hasSize) {
      if (compressed30.size!.width >= width && compressed30.size!.height >= height) {
        return image.getCompressed30Url();
      }
    }

    final compressed70 = ImageDimensions.fromPath(image.getCompressed70Url());
    if (compressed70.hasSize) {
      if (compressed70.size!.width >= width && compressed70.size!.height >= height) {
        return image.getCompressed70Url();
      }
    }

    return image.getEfficiencyUrl();
  }

  Widget _buildImage(BuildContext context, Size widgetSize) {
    if (imageObject == null) {
      return SizedBox.fromSize(size: widgetSize, child: _buildPlaceholder(context));
    }

    final url =
        getUrl != null && imageObject is CompressibleImageObject
            ? getUrl!(widgetSize, imageObject as CompressibleImageObject)
            : _getUrlBasedOnSize(widgetSize);

    final dimension = ImageDimensions.fromPath(url);

    final (cacheWidth, cacheHeight) = _calculateCacheDimensions(
      widgetSize,
      dimension.size?.aspectRatio,
    );

    final imageWidget =
        cache
            ? _buildCachedNetworkImage(context, url, widgetSize, cacheWidth, cacheHeight)
            : _buildOctoImage(context, url, widgetSize, cacheWidth, cacheHeight);

    return imageBuilder != null ? imageBuilder!(context, imageWidget) : imageWidget;
  }

  Widget _buildCachedNetworkImage(
    BuildContext context,
    String url,
    Size widgetSize,
    int? cacheWidth,
    int? cacheHeight,
  ) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      memCacheHeight: cacheHeight,
      memCacheWidth: cacheWidth,
      width: widgetSize.width,
      height: widgetSize.height,
      imageBuilder:
          (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: _getBorderRadius,
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
          ),
      errorWidget: _buildErrorWidget,
      imageRenderMethodForWeb:
          platformType.isWeb ? ImageRenderMethodForWeb.HttpGet : ImageRenderMethodForWeb.HtmlImage,
      placeholder: _loadingPlaceholder == null ? null : (_, __) => _loadingPlaceholder!,
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error, Object? s) {
    return errorWidget != null ? errorWidget!(context) : const _ErrorWidget();
  }

  Widget _buildOctoImage(
    BuildContext context,
    String url,
    Size widgetSize,
    int? cacheWidth,
    int? cacheHeight,
  ) {
    return OctoImage(
      image: NetworkImage(url),
      fit: fit,
      width: widgetSize.width,
      height: widgetSize.height,
      memCacheHeight: cacheHeight,
      memCacheWidth: cacheWidth,
      placeholderBuilder: _loadingPlaceholder == null ? null : (_) => _loadingPlaceholder!,
      errorBuilder: _buildErrorWidget,
      imageBuilder: (context, child) {
        return _getBorderRadius != null
            ? ClipRRect(borderRadius: _getBorderRadius!, child: child)
            : child;
      },
    );
  }

  (int?, int?) _calculateCacheDimensions(Size widgetSize, double? aspectRatio) {
    final effectiveAspectRatio = aspectRatio ?? imageAspectRatio;
    if (effectiveAspectRatio == null) return (null, null);

    final widgetAspectRatio = widgetSize.width / widgetSize.height;
    if (widgetAspectRatio > effectiveAspectRatio) {
      final height = widgetSize.height;
      return (null, height.toInt());
    } else {
      final width = widgetSize.width;
      return (width.toInt(), null);
    }
  }

  BorderRadiusGeometry? get _getBorderRadius =>
      borderRadius == null ? null : BorderRadius.circular(borderRadius!);

  Widget? get _loadingPlaceholder =>
      loadingEffect ? Skeletonizer(child: _buildPlaceholder(null)) : null;

  Widget _buildPlaceholder(BuildContext? context) => Skeleton.leaf(
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: context != null ? Theme.of(context).colorScheme.surface : context?.colors.secondary,
        borderRadius: _getBorderRadius,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (width != null && height != null) {
      final size = Size(width!, height!);
      imageWidget = _buildImage(context, size);
    } else {
      imageWidget = LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          return _buildImage(context, size);
        },
      );
    }

    if (border) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.outlineVariant.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
        ),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

class _ErrorWidget extends ConsumerWidget {
  const _ErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(padding: const EdgeInsets.all(8.0), child: Center(child: Icon(Icons.error))),
    );
  }
}
