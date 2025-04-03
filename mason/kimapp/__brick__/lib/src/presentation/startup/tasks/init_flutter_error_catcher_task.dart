import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kimapp/service.dart';

import '../startup.dart';

class InitFlutterErrorCatcherTask extends StartUpTask {
  const InitFlutterErrorCatcherTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    FlutterError.onError = (details) {
      Kimapp.instance.log(
        LoggerType.error,
        message: 'Uncaught flutter error',
        object: details.exception,
        stackTrace: details.stack,
      );

      if (context.env.isRelease) {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
        return;
      }
    };

    // Override error widget in release mode
    if (context.env.isRelease) {
      ErrorWidget.builder = (details) => const SizedBox();
    }
  }
}
