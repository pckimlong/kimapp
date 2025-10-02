part of 'bootstrap.dart';

final _statelessSplashTaskProvider = FutureProvider<bool>((ref) async {
  if (ref.state.valueOrNull != true) {
    final splashConfig = ref.watch(_splashConfigProvider);
    final tasks = _filterTasksByType<OneTimeSplashTask>(splashConfig?.tasks ?? []);
    if (tasks.isEmpty) return true;

    final logger = ref.watch(loggerProvider);
    final context = SplashContext(ref);

    logger.info('🎨 Starting ${tasks.length} one-time splash tasks');
    final start = DateTime.now();

    final disposables = <DisposalCallback>[];

    try {
      for (final task in tasks) {
        final disposable = await _executeTaskWithLogging(task, context, logger);
        if (disposable != null) {
          disposables.add(disposable);

          ref.onDispose(() {
            logger.info('🗑️ Disposing one-time task: ${task.runtimeType}');
            disposable();
          });
        }
      }

      final elapsed = DateTime.now().difference(start);
      logger.info('✅ Completed all one-time splash tasks in ${elapsed.inMilliseconds}ms');

      if (elapsed < (splashConfig?.minimumDuration ?? Duration.zero)) {
        final delayDuration = splashConfig!.minimumDuration - elapsed;
        logger.info(
          '⏱️  Enforcing minimum splash duration, delaying for ${delayDuration.inMilliseconds}ms',
        );
        await Future.delayed(delayDuration);
      }
    } catch (error) {
      logger.info('🧹 Cleaning up ${disposables.length} initialized one-time tasks due to failure');
      for (final disposable in disposables) {
        try {
          disposable();
        } catch (disposeError, disposeStack) {
          logger.error(
            'Failed to dispose task during error cleanup',
            error: disposeError,
            stackTrace: disposeStack,
          );
        }
      }
      rethrow;
    }
  }

  return true;
});

final _reactiveSplashTaskWatchProvider = FutureProvider.autoDispose.family<dynamic, int>((
  ref,
  taskIndex,
) async {
  final splashConfig = ref.watch(_splashConfigProvider);
  final tasks = _filterTasksByType<ReactiveSplashTask>(splashConfig?.tasks ?? []);

  if (taskIndex >= tasks.length) {
    throw StateError('Task index $taskIndex out of bounds (${tasks.length} tasks)');
  }

  final task = tasks.elementAt(taskIndex);
  final logger = ref.watch(loggerProvider);
  final taskName = task.runtimeType.toString();

  logger.info('👁️  Watching dependencies for task: $taskName (index: $taskIndex)');

  try {
    final watchData = await task.watch(ref);
    logger.info('👁️  Completed watch phase for task: $taskName');
    return watchData;
  } catch (error, stackTrace) {
    logger.error(
      '❌ Failed reactive splash task watch phase for $taskName',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
});

final _reactiveSplashTaskExecuteProvider = FutureProvider.autoDispose.family<void, int>((
  ref,
  taskIndex,
) async {
  final splashConfig = ref.watch(_splashConfigProvider);
  final tasks = _filterTasksByType<ReactiveSplashTask>(splashConfig?.tasks ?? []);

  if (taskIndex >= tasks.length) {
    throw StateError('Task index $taskIndex out of bounds (${tasks.length} tasks)');
  }

  final task = tasks.elementAt(taskIndex);
  final logger = ref.watch(loggerProvider);
  final taskName = task.runtimeType.toString();

  final watchedData = await ref.watch(_reactiveSplashTaskWatchProvider(taskIndex).future);

  logger.info('⚡ Starting execute phase for reactive task: $taskName (index: $taskIndex)');

  try {
    final disposable = await _executeReactiveTaskExecutePhase(task, watchedData, ref, logger);
    if (disposable != null) {
      ref.onDispose(() {
        logger.info('🗑️ Disposing reactive task: $taskName');
        disposable();
      });
    }

    logger.info('✅ Completed execute phase for reactive task: $taskName');
  } catch (error, stackTrace) {
    logger.error(
      '❌ Failed execute phase for reactive task: $taskName',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
});

Future<DisposalCallback?> _executeReactiveTaskExecutePhase(
  ReactiveSplashTask task,
  dynamic watchedData,
  Ref ref,
  Logger logger,
) async {
  final taskName = task.runtimeType.toString();
  final startTime = DateTime.now();

  logger.info('⚡ Starting execute phase for reactive task: $taskName');

  try {
    final executionContext = SplashContext(ref);
    final disposable = await task.execute(executionContext, watchedData);

    final duration = DateTime.now().difference(startTime);
    logger.info(
      '✅ Completed execute phase for reactive task: $taskName in ${duration.inMilliseconds}ms',
    );

    return disposable;
  } catch (error, stackTrace) {
    final duration = DateTime.now().difference(startTime);

    logger.error(
      '❌ Failed execute phase for reactive task: $taskName after ${duration.inMilliseconds}ms',
      error: error,
      stackTrace: stackTrace,
    );

    rethrow;
  }
}

Iterable<T> _filterTasksByType<T>(List<SplashTaskBase> tasks) {
  return tasks.whereType<T>().cast<T>();
}

Future<DisposalCallback?> _executeTaskWithLogging(
  SplashTask task,
  SplashContext context,
  Logger logger,
) async {
  final taskName = task.runtimeType.toString();
  final startTime = DateTime.now();

  logger.info('🚀 Starting splash task: $taskName');

  try {
    final disposable = await task.execute(context);
    final duration = DateTime.now().difference(startTime);

    logger.info('✅ Completed splash task: $taskName in ${duration.inMilliseconds}ms');

    return disposable;
  } catch (error, stackTrace) {
    final duration = DateTime.now().difference(startTime);

    logger.error(
      '❌ Failed splash task: $taskName after ${duration.inMilliseconds}ms',
      error: error,
      stackTrace: stackTrace,
    );

    rethrow;
  }
}
