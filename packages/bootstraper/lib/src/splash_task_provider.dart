part of 'bootstrap.dart';

final _internalLoggerProvider = Provider<Logger>((ref) {
  throw UnimplementedError(
    'Internal logger provider is not implemented. Please provide a Logger implementation.',
  );
});

final _statelessSplashTaskProvider = FutureProvider<bool>((ref) async {
  if (ref.state.valueOrNull != true) {
    final splashConfig = ref.watch(_splashConfigProvider);
    final tasks = (splashConfig?.tasks ?? []).whereType<StatelessSplashTask>();
    if (tasks.isEmpty) return true;

    final logger = ref.read(_internalLoggerProvider);
    final context = SplashContext(ref);

    logger.info('🎨 Starting ${tasks.length} stateless splash tasks');
    final start = DateTime.now();

    await Future.wait(tasks.map((task) => _executeStatelessTaskWithLogging(task, context, logger)));

    final elapsed = DateTime.now().difference(start);
    logger.info('✅ Completed all stateless splash tasks in ${elapsed.inMilliseconds}ms');

    if (elapsed < (splashConfig?.minimumDuration ?? Duration.zero)) {
      final delayDuration = splashConfig!.minimumDuration - elapsed;
      logger.info(
        '⏱️  Enforcing minimum splash duration, delaying for ${delayDuration.inMilliseconds}ms',
      );
      await Future.delayed(delayDuration);
    }
  }

  await ref.watch(_statefulSplashTaskProvider.future);
  return true;
});

/// A provider that manages the splash screen tasks and their execution.
/// This is a keep alive provider which will only run once.
final _statefulSplashTaskProvider = FutureProvider.autoDispose<bool>((ref) async {
  final splashConfig = ref.watch(_splashConfigProvider);
  final tasks = (splashConfig?.tasks ?? []).whereType<StatefulSplashTask>();
  if (tasks.isEmpty) return true;

  final logger = ref.read(_internalLoggerProvider);
  final context = SplashContext(ref);

  logger.info('🔄 Starting ${tasks.length} stateful splash tasks');

  for (final task in tasks) {
    final disposable = await _executeStatefulTaskWithLogging(task, context, logger);
    if (disposable != null) {
      ref.onDispose(() {
        logger.info('🗑️ Disposing stateful task: ${task.runtimeType}');
        disposable();
      });
    }
  }

  logger.info('✅ Completed all stateful splash tasks');
  return true;
});

/// Execute a single stateless task with comprehensive logging
Future<void> _executeStatelessTaskWithLogging(
  StatelessSplashTask task,
  SplashContext context,
  Logger logger,
) async {
  final taskName = task.runtimeType.toString();
  final startTime = DateTime.now();

  logger.info('🚀 Starting stateless splash task: $taskName');

  try {
    await task.execute(context);
    final duration = DateTime.now().difference(startTime);

    logger.info('✅ Completed stateless splash task: $taskName in ${duration.inMilliseconds}ms');
  } catch (error, stackTrace) {
    final duration = DateTime.now().difference(startTime);

    logger.error(
      '❌ Failed stateless splash task: $taskName after ${duration.inMilliseconds}ms',
      error: error,
      stackTrace: stackTrace,
    );

    rethrow;
  }
}

/// Execute a single stateful task with comprehensive logging
Future<DisposalCallback?> _executeStatefulTaskWithLogging(
  StatefulSplashTask task,
  SplashContext context,
  Logger logger,
) async {
  final taskName = task.runtimeType.toString();
  final startTime = DateTime.now();

  logger.info('🚀 Starting stateful splash task: $taskName');

  try {
    final disposable = await task.execute(context);
    final duration = DateTime.now().difference(startTime);

    logger.info('✅ Completed stateful splash task: $taskName in ${duration.inMilliseconds}ms');

    return disposable;
  } catch (error, stackTrace) {
    final duration = DateTime.now().difference(startTime);

    logger.error(
      '❌ Failed stateful splash task: $taskName after ${duration.inMilliseconds}ms',
      error: error,
      stackTrace: stackTrace,
    );

    rethrow;
  }
}
