import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_supabase_helper/supabase_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Global overrides for image handling
Future<ui.Image> Function(Uint8List)? imageDecoderOverride;
Future<Uint8List> Function(
  Uint8List bytes, {
  int? minWidth,
  int? minHeight,
  int? quality,
  bool? keepExif,
  bool? autoCorrectionAngle,
  CompressFormat? format,
  int? inSampleSize,
})? imageCompressorOverride;

class MockStorageClient extends Mock implements SupabaseStorageClient {}

class MockStorageFileApi extends Mock implements StorageFileApi {}

class MockImage extends Mock implements ui.Image {
  @override
  final int width;
  @override
  final int height;

  MockImage({required this.width, required this.height});
}

class MockImageDecoder {
  Future<ui.Image> Function(Uint8List)? _decoder;

  set decodeImageFromList(Future<ui.Image> Function(Uint8List) fn) {
    _decoder = fn;
  }

  Future<ui.Image> decode(Uint8List bytes) {
    if (_decoder == null) {
      throw UnimplementedError();
    }
    return _decoder!(bytes);
  }
}

class MockImageCompressor {
  Future<Uint8List> Function(
    Uint8List bytes, {
    int? minWidth,
    int? minHeight,
    int? quality,
    bool? keepExif,
    bool? autoCorrectionAngle,
    CompressFormat? format,
    int? inSampleSize,
  })? _compressor;

  set compress(
    Future<Uint8List> Function(
      Uint8List bytes, {
      int? minWidth,
      int? minHeight,
      int? quality,
      bool? keepExif,
      bool? autoCorrectionAngle,
      CompressFormat? format,
      int? inSampleSize,
    }) fn,
  ) {
    _compressor = fn;
  }

  Future<Uint8List> compressWithList(
    Uint8List bytes, {
    int? minWidth,
    int? minHeight,
    int? quality,
    bool? keepExif,
    bool? autoCorrectionAngle,
    CompressFormat? format,
    int? inSampleSize,
  }) {
    if (_compressor == null) {
      throw UnimplementedError();
    }
    return _compressor!(
      bytes,
      minWidth: minWidth,
      minHeight: minHeight,
      quality: quality,
      keepExif: keepExif,
      autoCorrectionAngle: autoCorrectionAngle,
      format: format,
      inSampleSize: inSampleSize,
    );
  }
}

// Create a concrete implementation of StorageObject for testing
class TestStorageObject extends StorageObject {
  @override
  String get bucket => 'test-bucket';

  String _path = 'test/path/file.txt';
  @override
  String get path => _path;
  set path(String value) => _path = value;
}

// Create a concrete implementation of CompressibleImageObject for testing
class TestCompressibleImageObject extends CompressibleImageObject {
  @override
  String get bucket => 'test-bucket';

  String _path = 'test/path/image.jpg';
  @override
  String get path => _path;
  set path(String value) => _path = value;
}

MockImage createMockImage({int width = 100, int height = 100}) {
  return MockImage(width: width, height: height);
}

void main() {
  setUpAll(() async {
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(const FileOptions());
    registerFallbackValue(CompressFormat.jpeg);

    // Initialize Kimapp for failure messages
    await Kimapp.initialize(debugMode: true);

    // Initialize StorageManager with test configuration
    StorageManager.initialize(
      config: const StorageConfig(
        bucketFileTypes: {
          'test-bucket': [FileType.image],
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
      ),
    );
  });

  group('FileType Tests', () {
    test('should detect image files correctly', () {
      final storageObject = TestStorageObject()..path = 'test/image.jpg';
      expect(storageObject.fileType, equals(FileType.image));

      storageObject.path = 'test/image.png';
      expect(storageObject.fileType, equals(FileType.image));

      storageObject.path = 'test/image.jpeg';
      expect(storageObject.fileType, equals(FileType.image));
    });

    test('should detect video files correctly', () {
      final storageObject = TestStorageObject()..path = 'test/video.mp4';
      expect(storageObject.fileType, equals(FileType.video));

      storageObject.path = 'test/video.mov';
      expect(storageObject.fileType, equals(FileType.video));
    });

    test('should detect audio files correctly', () {
      final storageObject = TestStorageObject()..path = 'test/audio.mp3';
      expect(storageObject.fileType, equals(FileType.audio));

      storageObject.path = 'test/audio.wav';
      expect(storageObject.fileType, equals(FileType.audio));
    });

    test('should detect PDF files correctly', () {
      final storageObject = TestStorageObject()..path = 'test/document.pdf';
      expect(storageObject.fileType, equals(FileType.pdf));
    });

    test('should return other for unknown file types', () {
      final storageObject = TestStorageObject()..path = 'test/unknown.xyz';
      expect(storageObject.fileType, equals(FileType.other));
    });

    test('fromMimeType correctly identifies file types', () {
      expect(FileType.fromMimeType('image/jpeg'), equals(FileType.image));
      expect(FileType.fromMimeType('video/mp4'), equals(FileType.video));
      expect(FileType.fromMimeType('audio/mpeg'), equals(FileType.audio));
      expect(FileType.fromMimeType('application/pdf'), equals(FileType.pdf));
      expect(FileType.fromMimeType('text/plain'), equals(FileType.other));
      expect(FileType.fromMimeType(null), equals(FileType.other));
    });

    test('file type getter methods work correctly', () {
      const imageType = FileType.image;
      expect(imageType.isImage, isTrue);
      expect(imageType.isVideo, isFalse);
      expect(imageType.isAudio, isFalse);
      expect(imageType.isPdf, isFalse);
      expect(imageType.isOther, isFalse);
    });
  });

  group('StorageManager Tests', () {
    test('default config has expected values', () {
      expect(StorageManager.config.maxFileSizeBytes, equals(10 * 1024 * 1024));
      expect(StorageManager.config.bucketFileTypes.containsKey('test-bucket'),
          isTrue);
      expect(StorageManager.config.typeSpecificMaxSizes[FileType.image],
          equals(5 * 1024 * 1024));
    });

    test('validateUpload succeeds for valid file', () {
      final result = StorageManager.validateUpload(
        bucket: 'profile_pictures',
        fileType: FileType.image,
        fileSize: 2 * 1024 * 1024,
      );
      expect(result.isRight(), isTrue);
    });

    test('validateUpload fails for invalid file type', () {
      final result = StorageManager.validateUpload(
        bucket: 'profile_pictures',
        fileType: FileType.video,
        fileSize: 2 * 1024 * 1024,
      );
      expect(result.isLeft(), isTrue);
    });

    test('validateUpload fails for oversized file', () {
      final result = StorageManager.validateUpload(
        bucket: 'profile_pictures',
        fileType: FileType.image,
        fileSize: 20 * 1024 * 1024,
      );
      expect(result.isLeft(), isTrue);
    });
  });

  group('Storage Operations Tests', () {
    late MockStorageClient mockClient;
    late MockStorageFileApi mockFileApi;
    late TestStorageObject storageObject;
    late TestCompressibleImageObject compressibleObject;

    setUp(() {
      mockClient = MockStorageClient();
      mockFileApi = MockStorageFileApi();
      storageObject = TestStorageObject();
      compressibleObject = TestCompressibleImageObject();

      // Mock the from method with positional parameter
      when(() => mockClient.from('test-bucket')).thenReturn(mockFileApi);
    });

    test('getUrl returns correct URL', () {
      const expectedUrl = 'https://example.com/test-bucket/test/path/file.txt';
      when(() => mockFileApi.getPublicUrl('test/path/file.txt'))
          .thenReturn(expectedUrl);

      final url = storageObject.getUrl(client: mockClient);
      expect(url, equals(expectedUrl));
      verify(() => mockClient.from('test-bucket')).called(1);
      verify(() => mockFileApi.getPublicUrl('test/path/file.txt')).called(1);
    });

    test('upload fails with invalid file type', () async {
      final testBytes = Uint8List.fromList([1, 2, 3]);
      storageObject.path = 'test/path/video.mp4'; // Set path to video file

      final result = await storageObject.upload(testBytes, client: mockClient);
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message(), contains('File type')),
        (_) => fail('Should return left'),
      );
    });

    test('upload fails with oversized file', () async {
      final testBytes = Uint8List(11 * 1024 * 1024); // 11MB file
      storageObject.path = 'test/path/image.jpg'; // Set to valid image type

      final result = await storageObject.upload(testBytes, client: mockClient);
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) =>
            expect(failure.message(), contains('maximum allowed size')),
        (_) => fail('Should return left'),
      );
    });

    test('upload handles storage API error', () async {
      final testBytes = Uint8List.fromList([1, 2, 3]);
      storageObject.path = 'test/path/image.jpg'; // Set to valid image type
      when(() => mockFileApi.uploadBinary(any(), any(),
              fileOptions: any(named: 'fileOptions')))
          .thenThrow(const StorageException('Storage API error'));

      final result = await storageObject.upload(testBytes, client: mockClient);
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message(), contains('Storage API error')),
        (_) => fail('Should return left'),
      );
    });

    test('getBytes handles storage API error', () async {
      when(() => mockFileApi.download(any()))
          .thenThrow(const StorageException('Download failed'));

      final result = await storageObject.getBytes(client: mockClient);
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message(), contains('Download failed')),
        (_) => fail('Should return left'),
      );
    });

    test('delete handles storage API error', () async {
      when(() => mockFileApi.remove(any()))
          .thenThrow(const StorageException('Delete failed'));

      final result = await storageObject.delete(client: mockClient);
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message(), contains('Delete failed')),
        (_) => fail('Should return left'),
      );
    });
  });
}
