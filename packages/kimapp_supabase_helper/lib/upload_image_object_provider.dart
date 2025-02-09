import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:dartx/dartx.dart';
import 'package:image/image.dart' as img;
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_supabase_helper/helper.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slugify/slugify.dart';
import 'package:uuid/uuid.dart';

import 'supabase_storage.dart';

part 'upload_image_object_provider.g.dart';

/// Model to store image dimensions
class ImageDimensions {
  final double? width;
  final double? height;

  const ImageDimensions({
    required this.width,
    required this.height,
  });

  @override
  String toString() {
    if (width == null || height == null) {
      return '';
    }
    return '${width}x$height';
  }

  String toPath(String filePath) {
    if (width == null || height == null) {
      return filePath;
    }

    final extension = p.extension(filePath);
    final pathWithoutExtension = p.basenameWithoutExtension(filePath);

    // Check if path already contains dimensions
    final hasDimensions = RegExp(r'\d+\.?\d*x\d+\.?\d*$').hasMatch(pathWithoutExtension);

    if (hasDimensions) {
      // Replace existing dimensions
      return '${pathWithoutExtension.replaceFirst(RegExp(r'\d+\.?\d*x\d+\.?\d*$'), toString())}$extension';
    } else {
      // Add dimensions at the end
      return '$pathWithoutExtension-${toString()}$extension';
    }
  }

  factory ImageDimensions.fromPath(String path) {
    // Regular expression to match dimensions pattern
    // Matches both integer and decimal numbers
    final regex = RegExp(r'(\d+\.?\d*)x(\d+\.?\d*)');

    // Find all matches in the path
    final matches = regex.allMatches(path);

    // If no matches found, return null
    if (matches.isEmpty) {
      return const ImageDimensions(width: null, height: null);
    }

    // Use the last match in case there are multiple dimension-like patterns
    final match = matches.last;

    try {
      final width = double.tryParse(match.group(1)!);
      final height = double.tryParse(match.group(2)!);

      return ImageDimensions(width: width, height: height);
    } on FormatException {
      return const ImageDimensions(width: null, height: null);
    }
  }
}

@riverpod
class UploadImageObject extends _$UploadImageObject {
  @override
  ProviderStatus<BaseStorageObject> build() => const ProviderStatus.initial();

  /// Validates and sanitizes the filename
  String _validateFilename(String filename) {
    // Remove any directory traversal attempts
    filename = p.basename(filename);

    // Get extension and base name
    final extension = p.extension(filename).toLowerCase();
    final basename = p.basenameWithoutExtension(filename);

    // Sanitize basename using slugify
    final sanitizedName = slugify(
      basename,
      delimiter: '-',
      lowercase: true,
    );

    if (sanitizedName.isEmpty) {
      throw Exception('Invalid filename after sanitization');
    }

    return '$sanitizedName$extension';
  }

  /// Extracts image dimensions from the file
  Future<ImageDimensions> _getImageDimensions(Uint8List bytes) async {
    final image = img.decodeImage(bytes);

    if (image == null) {
      throw Exception('Could not decode image');
    }

    return ImageDimensions(
      width: image.width.toDouble(),
      height: image.height.toDouble(),
    );
  }

  /// Upload the file to storage and return the object
  /// It will auto generate the path including image dimensions
  Future<ProviderStatus<T>> call<T extends BaseStorageObject>(
    XFile image, {
    required T Function(String generatedPath) object,
    String? customPrefix,
    String directory = '',
    bool upsert = false,
  }) async {
    return await perform(
      (state) async {
        // Validate filename
        final validFilename = _validateFilename(image.path);

        final fileBytes = await image.readAsBytes();

        // Get image dimensions
        final dimensions = await _getImageDimensions(fileBytes);

        // Generate storage path
        final bucketName = object('-').bucket;
        final filename = customPrefix ?? const Uuid().v4();

        final imagePath = [
              bucketName,
              filename,
              if (dimensions.toString().isNotBlank) dimensions.toString(),
            ].join('-') +
            p.extension(validFilename);

        final storagePath = directory.isNotEmpty ? p.join(directory, imagePath) : imagePath;

        // Create and upload storage object
        final storageObject = object(storagePath);
        final uploadResult = await storageObject.upload(
          fileBytes,
          client: ref.supabaseStorage,
          upsert: upsert,
        );

        return uploadResult.getOrThrow();
      },
      onSuccess: (success) {
        ref.invalidateSelf();
      },
    ) as ProviderStatus<T>;
  }
}

extension ProviderStatusClassFamilyNotifierX on BuildlessAutoDisposeNotifier {
  /// Wrapper function to handle image upload and callback execution
  /// This can be use to make sure if the upload is successful, the callback will be executed
  /// but failed upload will be handled and deleted
  ///
  ///
  /// [T] The return type of the callback function
  /// [M] The type of storage object to be created, must extend BaseStorageObject
  /// [image] The image file to upload
  /// [object] Function to create the storage object
  /// [callback] Function to execute after successful upload
  /// [customPrefix] Optional prefix for the generated filename
  /// [directory] Optional directory path
  /// [upsert] Whether to overwrite existing files
  Future<T> uploadImageWrapper<T, M extends BaseStorageObject>(
    XFile image,
    M Function(String generatedPath) object, {
    required FutureOr<T> Function(M image) callback,
    String? customPrefix,
    String directory = '',
    bool upsert = false,
  }) async {
    final uploadResult = await ref.read(uploadImageObjectProvider.notifier).call<BaseStorageObject>(
          image,
          object: object,
          customPrefix: customPrefix,
          directory: directory,
          upsert: upsert,
        );

    if (uploadResult.isSuccess) {
      try {
        return callback(uploadResult as M);
      } catch (_) {
        await uploadResult.successOrNull!.delete(client: ref.supabaseStorage);
        rethrow;
      }
    }

    throw uploadResult;
  }
}
