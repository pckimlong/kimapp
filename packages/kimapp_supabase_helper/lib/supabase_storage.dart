import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Represents different types of files that can be stored
enum FileType {
  any,
  image,
  video,
  audio,
  pdf,
  other;

  static FileType fromMimeType(String? mimeType) {
    if (mimeType == null) return FileType.other;

    if (mimeType.startsWith('image/')) return FileType.image;
    if (mimeType.startsWith('video/')) return FileType.video;
    if (mimeType.startsWith('audio/')) return FileType.audio;
    if (mimeType.endsWith('pdf')) return FileType.pdf;

    return FileType.other;
  }

  static FileType fromPath(String path) {
    final mimeType = lookupMimeType(path);
    return FileType.fromMimeType(mimeType);
  }

  bool get isImage => this == FileType.image;
  bool get isVideo => this == FileType.video;
  bool get isAudio => this == FileType.audio;
  bool get isPdf => this == FileType.pdf;
  bool get isOther => this == FileType.other;
}

/// Global storage configuration manager
class StorageManager {
  static late StorageConfig config;

  /// Initialize storage configuration
  static void initialize({StorageConfig? config}) {
    StorageManager.config = config ?? StorageConfig.defaultConfig();
  }

  /// Validate file upload against configuration
  static Either<Failure, Unit> validateUpload({
    required String bucket,
    required FileType fileType,
    required int fileSize,
  }) {
    // Check if file type is allowed in bucket
    if (!config.isFileTypeAllowedInBucket(bucket, fileType)) {
      return left(Failure.fromString(
        'File type ${fileType.name} is not allowed in bucket $bucket',
      ));
    }

    // Check file size
    final maxSize = config.getMaxSizeForType(fileType);
    if (fileSize > maxSize) {
      return left(Failure.fromString(
        'File size exceeds maximum allowed size of ${maxSize ~/ 1024 ~/ 1024}MB',
      ));
    }

    return right(unit);
  }
}

/// Storage configuration class
class StorageConfig {
  final Map<String, List<FileType>> bucketFileTypes;
  final int maxFileSizeBytes;
  final Map<FileType, int> typeSpecificMaxSizes;

  const StorageConfig({
    required this.bucketFileTypes,
    this.maxFileSizeBytes = 10 * 1024 * 1024, // 10MB default
    this.typeSpecificMaxSizes = const {},
  });

  /// Default configuration with common settings
  factory StorageConfig.defaultConfig() {
    return const StorageConfig(
      bucketFileTypes: {
        'profile_pictures': [FileType.image],
        'documents': [FileType.pdf, FileType.other],
        'media': [FileType.image, FileType.video, FileType.audio],
        'public': [FileType.any],
      },
      maxFileSizeBytes: 10 * 1024 * 1024,
      typeSpecificMaxSizes: {
        FileType.image: 5 * 1024 * 1024,
        FileType.video: 50 * 1024 * 1024,
        FileType.pdf: 15 * 1024 * 1024,
      },
    );
  }

  bool isFileTypeAllowedInBucket(String bucket, FileType type) {
    final allowedTypes = bucketFileTypes[bucket];
    if (allowedTypes == null) return false;
    return allowedTypes.contains(FileType.any) || allowedTypes.contains(type);
  }

  int getMaxSizeForType(FileType type) {
    return typeSpecificMaxSizes[type] ?? maxFileSizeBytes;
  }
}

/// Base class for all storage objects
abstract class BaseStorageObject {
  String get bucket;
  String get path;

  /// Whether the object can be compressed (typically images)
  bool get compressible => false;

  /// Allowed file types for this storage object
  List<FileType> get types;

  /// The detected file type based on mime type
  FileType get fileType => FileType.fromMimeType(mimeType);

  /// File extension (e.g., '.jpg', '.pdf')
  String get fileExtension => p.extension(path);

  /// File name without extension
  String get name => p.basenameWithoutExtension(path);

  /// Complete file name with extension
  String get fileName => p.basename(path);

  /// Detected mime type
  String? get mimeType => lookupMimeType(path);

  ImageDimensions? get dimensions {
    if (!fileType.isImage) return null;
    return ImageDimensions.fromPath(path);
  }

  @override
  bool operator ==(covariant BaseStorageObject other) {
    if (identical(this, other)) return true;
    return other.path == path;
  }

  @override
  int get hashCode => path.hashCode;

  @override
  String toString() => 'StorageObject(path: $path)';

  String call() => path;

  String toJson() => path;

  /// Get public URL for the file
  String getUrl({SupabaseStorageClient? client}) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final storage = client ?? Supabase.instance.client.storage;
    return storage.from(bucket).getPublicUrl(path);
  }

  /// Upload the file bytes
  Future<Either<Failure, BaseStorageObject>> upload(
    Uint8List bytes, {
    SupabaseStorageClient? client,
    bool upsert = false,
  }) async {
    // Validate against configuration
    final validationResult = StorageManager.validateUpload(
      bucket: bucket,
      fileType: fileType,
      fileSize: bytes.length,
    );

    if (validationResult.isLeft()) {
      return left(validationResult.fold(
        (failure) => failure,
        (_) => Failure.fromString('Unknown validation error'),
      ));
    }

    return await performUpload(bytes, client: client, upsert: upsert);
  }

  /// Actual upload implementation to be provided by subclasses
  Future<Either<Failure, BaseStorageObject>> performUpload(
    Uint8List bytes, {
    SupabaseStorageClient? client,
    bool upsert = false,
  });

  /// Get the file bytes
  Future<Either<Failure, Uint8List>> getBytes(
      {SupabaseStorageClient? client}) async {
    return await errorHandler(() async {
      final storage = client ?? Supabase.instance.client.storage;
      final bytes = await storage.from(bucket).download(path);
      return right(bytes);
    });
  }

  Future<Either<Failure, Unit>> delete({SupabaseStorageClient? client});
}

/// For testing purposes
typedef ImageDecoder = Future<ui.Image> Function(Uint8List);
typedef ImageCompressor = Future<Uint8List> Function(
  Uint8List bytes, {
  int? minWidth,
  int? minHeight,
  int? quality,
  bool? keepExif,
  bool? autoCorrectionAngle,
  CompressFormat? format,
  int? inSampleSize,
});

ImageDecoder? imageDecoderOverride;
ImageCompressor? imageCompressorOverride;

/// Storage object specifically for compressible images with multiple quality versions
/// Configuration for image compression
/// TODO: We can make compression more flexible by using this, each app used it can config List of this, mean supporting compression format, we can use this to get whatever size we want
/// The idea is to accept list of compression config, and it use it to get url for each compression version
class CompressConfig {
  final int quality;
  final int targetWidth;

  const CompressConfig({
    this.quality = 80,
    this.targetWidth = 800,
  });
}

const _compressedImageExtension = "webp";
const _compressFormat = CompressFormat.webp;

abstract class CompressibleImageObject extends BaseStorageObject {
  @override
  bool get compressible => true;

  @override
  List<FileType> get types => [FileType.image];

  String get _efficiencyPath {
    final newPath = p.withoutExtension(path);
    return "$newPath-original.$_compressedImageExtension";
  }

  (String, ImageDimensions?) get _compressed70Path {
    if (dimensions?.hasSize == false) {
      return ("$path-compressed-70.$_compressedImageExtension", null);
    }

    // recalculate dimension by multiplying by 0.8
    final width = dimensions!.width! * 0.8;
    final height = dimensions!.height! * 0.8;
    final newDimensions = ImageDimensions(width: width, height: height);
    final newPath = p.withoutExtension(newDimensions.toPath(path));
    return ("$newPath-compressed-70.$_compressedImageExtension", newDimensions);
  }

  (String, ImageDimensions?) get _compressed30Path {
    if (dimensions?.hasSize == false) {
      return ("$path-compressed-30.$_compressedImageExtension", null);
    }

    // recalculate dimension by multiplying by 0.4
    final width = dimensions!.width! * 0.4;
    final height = dimensions!.height! * 0.4;
    final newDimensions = ImageDimensions(width: width, height: height);
    final newPath = p.withoutExtension(newDimensions.toPath(path));
    return ("$newPath-compressed-30.$_compressedImageExtension", newDimensions);
  }

  //! Keep to make compilable with old version
  /// Path for the first compression level (80% quality)
  String get _compressedPath1 => "${name}_compressed_1$fileExtension";

  /// Path for the second compression level (40% quality)
  String get _compressedPath2 => "${name}_compressed_2$fileExtension";

  @override
  Future<Either<Failure, CompressibleImageObject>> performUpload(
    Uint8List bytes, {
    SupabaseStorageClient? client,
    bool upsert = false,
  }) async {
    return await errorHandler(() async {
      // Validate file type first
      if (!fileType.isImage) {
        return left(Failure.fromString('Invalid file type: expected image'));
      }

      // Validate against storage configuration
      final validationResult = StorageManager.validateUpload(
        bucket: bucket,
        fileType: fileType,
        fileSize: bytes.length,
      );

      if (validationResult.isLeft()) {
        return validationResult.fold(
          (failure) => left(failure),
          (_) => left(Failure.fromString('Unknown validation error')),
        );
      }

      final storage = client ?? Supabase.instance.client.storage;
      final api = storage.from(bucket);
      final option = FileOptions(contentType: mimeType, upsert: upsert);

      // Upload original file
      await api.uploadBinary(path, bytes, fileOptions: option);

      try {
        final efficiency = await _compress(
          bytes,
          quality: 97,
          targetWidth: 1200,
          dimensions: dimensions,
        );

        final quality70 = await _compress(
          bytes,
          quality: 70,
          targetWidth: 1200,
          dimensions: dimensions,
        );

        final quality30 = await _compress(
          bytes,
          quality: 30,
          targetWidth: 400,
          dimensions: dimensions,
        );

        // Upload compressed versions in parallel
        await Future.wait([
          api.uploadBinary(
            _efficiencyPath,
            efficiency,
            fileOptions: FileOptions(
              contentType: lookupMimeType(_efficiencyPath),
              upsert: upsert,
            ),
          ),
          api.uploadBinary(
            _compressed70Path.$1,
            quality70,
            fileOptions: FileOptions(
              contentType: lookupMimeType(_compressed70Path.$1),
              upsert: upsert,
            ),
          ),
          api.uploadBinary(
            _compressed30Path.$1,
            quality30,
            fileOptions: FileOptions(
              contentType: lookupMimeType(_compressed30Path.$1),
              upsert: upsert,
            ),
          ),
        ]);

        return right(this);
      } catch (e) {
        // If compression fails, delete the original file, since not success upload might cause error when access compressed files
        await delete(client: storage);
        rethrow;
      }
    });
  }

  /// Compress image while maintaining aspect ratio
  Future<Uint8List> _compress(
    Uint8List bytes, {
    required int quality,
    int targetWidth = 800, // Default target width for compressed images
    ImageDimensions? dimensions,
  }) async {
    if (dimensions != null) {
      final width = dimensions.width!;
      final height = dimensions.height!;
      return await FlutterImageCompress.compressWithList(
        bytes,
        minWidth: width.toInt(),
        minHeight: height.toInt(),
        quality: quality,
        keepExif: true,
        autoCorrectionAngle: true,
        format: kIsWeb
            ? _compressFormat
            : Platform.isMacOS
                ? CompressFormat.jpeg
                : CompressFormat.webp,
        inSampleSize: 1,
      );
    }

    // Use override for testing if available
    if (imageDecoderOverride != null && imageCompressorOverride != null) {
      final image = await imageDecoderOverride!(bytes);
      final originalWidth = image.width;
      final originalHeight = image.height;

      final aspectRatio = originalWidth / originalHeight;
      final targetHeight = (targetWidth / aspectRatio).round();

      return await imageCompressorOverride!(
        bytes,
        minWidth: targetWidth,
        minHeight: targetHeight,
        quality: quality,
        keepExif: true,
        autoCorrectionAngle: true,
        format: kIsWeb
            ? _compressFormat
            : Platform.isMacOS
                ? CompressFormat.jpeg
                : CompressFormat.webp,
        inSampleSize: 1,
      );
    }

    // Decode image to get dimensions
    final image = await decodeImageFromList(bytes);
    final originalWidth = image.width;
    final originalHeight = image.height;

    // Calculate new dimensions maintaining aspect ratio
    final aspectRatio = originalWidth / originalHeight;
    final targetHeight = (targetWidth / aspectRatio).round();

    return await FlutterImageCompress.compressWithList(
      bytes,
      minWidth: targetWidth,
      minHeight: targetHeight,
      quality: quality,
      // Keep EXIF info for proper image orientation
      keepExif: true,
      // Rotate image according to EXIF data
      autoCorrectionAngle: true,
      // Format-specific options
      format: kIsWeb
          ? _compressFormat
          : Platform.isMacOS
              ? CompressFormat.jpeg
              : CompressFormat.webp,
      // Retain some color quality
      inSampleSize: 1, // Don't skip pixels
    );
  }

  /// Delete all versions of the image
  @override
  Future<Either<Failure, Unit>> delete({SupabaseStorageClient? client}) async {
    return await errorHandler(() async {
      final storage = client ?? Supabase.instance.client.storage;
      final api = storage.from(bucket);
      await api.remove([path, _compressedPath1, _compressedPath2]);
      return right(unit);
    });
  }

  /// Get URL for the first compressed version (80% quality)
  String getCompressed1Url({SupabaseStorageClient? client}) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final storage = client ?? Supabase.instance.client.storage;
    return storage.from(bucket).getPublicUrl(_compressedPath1);
  }

  /// Get URL for the second compressed version (40% quality)
  String getCompressed2Url({SupabaseStorageClient? client}) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final storage = client ?? Supabase.instance.client.storage;
    return storage.from(bucket).getPublicUrl(_compressedPath2);
  }

  String getEfficiencyUrl({SupabaseStorageClient? client}) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final storage = client ?? Supabase.instance.client.storage;
    return storage.from(bucket).getPublicUrl(_efficiencyPath);
  }

  String getCompressed70Url({SupabaseStorageClient? client}) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final storage = client ?? Supabase.instance.client.storage;
    return storage.from(bucket).getPublicUrl(_compressed70Path.$1);
  }

  String getCompressed30Url({SupabaseStorageClient? client}) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final storage = client ?? Supabase.instance.client.storage;
    return storage.from(bucket).getPublicUrl(_compressed30Path.$1);
  }
}

/// Generic storage object for any file type
abstract class StorageObject extends BaseStorageObject {
  @override
  List<FileType> get types => [FileType.any];

  @override
  Future<Either<Failure, StorageObject>> performUpload(
    Uint8List bytes, {
    SupabaseStorageClient? client,
    bool upsert = false,
  }) async {
    return await errorHandler(() async {
      final storage = client ?? Supabase.instance.client.storage;
      final api = storage.from(bucket);
      final option = FileOptions(contentType: mimeType, upsert: upsert);
      await api.uploadBinary(path, bytes, fileOptions: option);
      return right(this);
    });
  }

  @override
  Future<Either<Failure, Unit>> delete({SupabaseStorageClient? client}) async {
    return await errorHandler(() async {
      final storage = client ?? Supabase.instance.client.storage;
      final api = storage.from(bucket);
      await api.remove([path]);
      return right(unit);
    });
  }
}

// // Example implementations
// class ProfilePicture extends CompressibleImageObject {
//   @override
//   String get bucket => 'profile_pictures';

//   @override
//   final String path;

//   ProfilePicture(this.path);

//   factory ProfilePicture.fromUserId(String userId) {
//     return ProfilePicture('$userId.jpg');
//   }
// }

// class DocumentFile extends StorageObject {
//   @override
//   String get bucket => 'documents';

//   @override
//   final String path;

//   @override
//   List<FileType> get types => [FileType.pdf];

//   DocumentFile(this.path);
// }

// Example usage
// void main() async {
//   // Initialize storage configuration
//   StorageManager.initialize(
//     config: const StorageConfig(
//       bucketFileTypes: {
//         'profile_pictures': [FileType.image],
//         'chat_attachments': [FileType.image, FileType.pdf],
//         'product_images': [FileType.image],
//         'documents': [FileType.pdf],
//       },
//       maxFileSizeBytes: 10 * 1024 * 1024,
//       typeSpecificMaxSizes: {
//         FileType.image: 5 * 1024 * 1024,
//         FileType.pdf: 20 * 1024 * 1024,
//       },
//     ),
//   );

//   // Create and use a profile picture object
//   final profilePic = ProfilePicture.fromUserId('user123');
//   final bytes = Uint8List(1000); // Your image bytes

//   final result = await profilePic.upload(bytes);
//   result.fold(
//     (failure) => print('Upload failed: ${failure.message}'),
//     (success) {
//       print('Original URL: ${success.getUrl()}');
//       if (success is CompressibleImageObject) {
//         print('Compressed URL 1: ${success.getCompressed1Url()}');
//         print('Compressed URL 2: ${success.getCompressed2Url()}');
//       }
//     },
//   );
// }
