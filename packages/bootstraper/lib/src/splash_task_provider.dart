part of 'bootstrap.dart';

/// Provider that manages one-time splash tasks execution.
///
/// This provider executes all one-time splash tasks and handles their lifecycle:
/// - Executes tasks sequentially to maintain proper initialization order
/// - Collects disposal callbacks from tasks that can dispose resources
/// - Implements proper cleanup on failure (disposes initialized tasks before retry)
/// - Enforces minimum splash duration if configured
/// - Waits for reactive tasks to complete before returning success
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
      // Execute tasks sequentially to ensure proper initialization order
      for (final task in tasks) {
        final disposable = await _executeTaskWithLogging(task, context, logger);
        if (disposable != null) {
          disposables.add(disposable);
          // Register disposal callback with provider lifecycle
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
      // Critical: Dispose all successfully initialized tasks before retrying
      // This ensures clean state for retry attempts and prevents resource leaks
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

  // This allow it to execute only once
  return true;
});

/// Provider that manages individual reactive splash task watch phase.
///
/// This provider handles only the WATCH phase for a single [ReactiveSplashTask].
/// Each task gets its own provider instance to ensure precise dependency isolation:
/// - Only the specific task's dependencies trigger re-execution
/// - No unnecessary executions when other tasks' dependencies change
/// - Better performance and more predictable behavior
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

/// Provider that manages individual reactive splash task execution phase.
///
/// This provider handles only the EXECUTE phase for a single [ReactiveSplashTask].
/// Each task executes independently based on its own watch data changes:
/// - Only executes when the specific task's watch data changes
/// - No unnecessary executions when other tasks' dependencies change
/// - Maintains proper disposal lifecycle per task
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

  // Get the watched data for this specific task
  final watchedData = await ref.watch(_reactiveSplashTaskWatchProvider(taskIndex).future);

  logger.info('⚡ Starting execute phase for reactive task: $taskName (index: $taskIndex)');

  try {
    final disposable = await _executeReactiveTaskExecutePhase(task, watchedData, ref, logger);
    if (disposable != null) {
      // Register disposal callback with provider lifecycle
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


/// Executes only the execute phase of a reactive splash task.
///
/// This function handles the execution phase separately from the watch phase.
/// The watched data is provided as a parameter, and execution happens in a
/// separate provider context that doesn't affect splash display behavior.
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
    // Execute phase with watched data - ref.watch() calls here won't trigger splash
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

/// Helper function to filter tasks by type, handling generic type parameters correctly.
///
/// This is needed because `whereType<T>()` doesn't work properly with generic types.
/// For example, `ReactiveSplashTask<String, void>` won't match `whereType<ReactiveSplashTask>()`.
///
/// Note: The lint `prefer_iterable_wheretype` is intentionally ignored here because
/// `whereType<T>()` fails with generic types like `ReactiveSplashTask<WatchData, Result>`.
Iterable<T> _filterTasksByType<T>(List<SplashTaskBase> tasks) {
  // ignore: prefer_iterable_wheretype
  return tasks.where((task) => task is T).cast<T>();
}

/// Unified task execution function that handles both one-time and reactive splash tasks.
///
/// This function provides:
/// - Comprehensive logging for task lifecycle (start, completion, failure)
/// - Proper error handling with detailed error information
/// - Execution timing measurement for performance monitoring
/// - Support for disposal callbacks from both task types (since both inherit from SplashTask&lt;DisposalCallback?&gt;)
///
/// The unified approach ensures consistent behavior between one-time and reactive tasks,
/// particularly important for disposal handling during failures and retries.
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
