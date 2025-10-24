part of 'bootstrap.dart';

class SplashBuilder extends ConsumerStatefulWidget {
  const SplashBuilder({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashBuilderState();
}

class _SplashBuilderState extends ConsumerState<SplashBuilder> {
  final Set<int> _changedWatchValues = {};

  final Map<int, bool> _activeWatchValues = {};

  final Map<int, bool> _activeExecuteTasks = {};

  bool get isReactiveTasksLoading {
    return _changedWatchValues.isNotEmpty ||
        _activeWatchValues.values.any((isLoading) => isLoading) ||
        _activeExecuteTasks.values.any((isLoading) => isLoading);
  }

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    final config = ref.read(_splashConfigProvider);
    if (config == null) return;

    final reactiveTasks = _filterTasksByType<ReactiveSplashTask>(config.tasks);

    _initializeTaskStates(reactiveTasks.length);

    for (int taskIndex = 0; taskIndex < reactiveTasks.length; taskIndex++) {
      _setupWatchProviderListener(taskIndex);
      _setupExecuteProviderListener(taskIndex);
    }
  }

  void _initializeTaskStates(int taskCount) {
    for (int i = 0; i < taskCount; i++) {
      _changedWatchValues.add(i);
      _activeWatchValues[i] = true;
      _activeExecuteTasks[i] = true;
    }
  }

  void _setupWatchProviderListener(int taskIndex) {
    ref.listenManual(_reactiveSplashTaskWatchProvider(taskIndex), (previous, next) {
      setState(() {
        if (previous?.value != next.value) {
          _changedWatchValues.add(taskIndex);
        }

        _activeWatchValues[taskIndex] = !next.hasValue;
      });
    });
  }

  void _setupExecuteProviderListener(int taskIndex) {
    ref.listenManual(_reactiveSplashTaskExecuteProvider(taskIndex), (previous, next) {
      if (_changedWatchValues.contains(taskIndex)) {
        setState(() {
          if (next.hasValue) {
            _activeExecuteTasks[taskIndex] = false;
            _changedWatchValues.remove(taskIndex);
          } else {
            _activeExecuteTasks[taskIndex] = true;
          }
        });
      }
    });
  }

  bool _shouldShowSplash(SplashConfig config, AsyncValue<bool> oneTimeSplashTask) {
    if (!oneTimeSplashTask.hasValue) {
      return true;
    }

    if (isReactiveTasksLoading) {
      if (!config.showSplashWhenDependencyChanged && oneTimeSplashTask.hasValue) {
        _clearReactiveTaskStates();
        return false;
      }
      return true;
    }

    return false;
  }

  void _clearReactiveTaskStates() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          for (int i = 0; i < _activeExecuteTasks.length; i++) {
            _activeExecuteTasks[i] = false;
            _activeWatchValues[i] = false;
          }
          _changedWatchValues.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(_splashConfigProvider);
    if (config == null) {
      return widget.child;
    }

    final oneTimeSplashTask = ref.watch(_statelessSplashTaskProvider);

    final shouldShowSplash = _shouldShowSplash(config, oneTimeSplashTask);

    if (!shouldShowSplash) {
      return widget.child;
    }

    return config.pageBuilder(
      _getFirstError(ref, config, oneTimeSplashTask),

      _hasAnyError(ref, config, oneTimeSplashTask) ? _createRetryCallback(oneTimeSplashTask) : null,
    );
  }

  VoidCallback _createRetryCallback(AsyncValue<bool> oneTimeSplashTask) {
    return () {
      for (final taskIndex in _activeExecuteTasks.keys) {
        ref.invalidate(_reactiveSplashTaskWatchProvider(taskIndex));
        ref.invalidate(_reactiveSplashTaskExecuteProvider(taskIndex));
      }

      if (oneTimeSplashTask.hasError) {
        ref.invalidate(_statelessSplashTaskProvider);
      }

      setState(() {
        _activeExecuteTasks.clear();
        _activeWatchValues.clear();
        _changedWatchValues.clear();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setupListeners();
      });
    };
  }

  Object? _getFirstError(WidgetRef ref, SplashConfig config, AsyncValue<bool> oneTimeTask) {
    if (oneTimeTask.hasError) {
      return oneTimeTask.error;
    }

    final tasks = _filterTasksByType<ReactiveSplashTask>(config.tasks);
    for (int i = 0; i < tasks.length; i++) {
      final watchState = ref.read(_reactiveSplashTaskWatchProvider(i));
      if (watchState.hasError) {
        return watchState.error;
      }

      final executeState = ref.read(_reactiveSplashTaskExecuteProvider(i));
      if (executeState.hasError) {
        return executeState.error;
      }
    }

    return null;
  }

  bool _hasAnyError(WidgetRef ref, SplashConfig config, AsyncValue<bool> oneTimeTask) {
    if (oneTimeTask.hasError) {
      return true;
    }

    final tasks = _filterTasksByType<ReactiveSplashTask>(config.tasks);
    for (int i = 0; i < tasks.length; i++) {
      final watchState = ref.read(_reactiveSplashTaskWatchProvider(i));
      if (watchState.hasError) {
        return true;
      }

      final executeState = ref.read(_reactiveSplashTaskExecuteProvider(i));
      if (executeState.hasError) {
        return true;
      }
    }

    return false;
  }
}
