import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/riverpod_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "file_from_url_provider.g.dart";

/// Provide use to get uint8list from url and also cache it
@riverpod
FutureOr<File?> fileFromUrl(Ref ref, String? url) async {
  ref.cacheTime(const Duration(minutes: 3));

  if (url == null) return null;
  final path = await ref.watch(_tempDirProvider.future);
  final filename = url.hashCode.toString();
  final file = File('$path/$filename');

  if (await file.exists()) {
    return file;
  }

  final byte = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
  await file.writeAsBytes(byte);
  return file;
}

@riverpod
FutureOr<String> _tempDir(_TempDirRef ref) {
  return getTemporaryDirectory().then((value) => value.path);
}
