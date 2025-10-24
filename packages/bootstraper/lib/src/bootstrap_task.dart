part of 'bootstrap.dart';

typedef DisposalCallback = VoidCallback;

class BootstrapContext {
  final IntegrationMode env;

  final ProviderContainer container;

  final Logger logger;

  BootstrapContext({required this.container, required this.env, required this.logger});
}

class SplashContext {
  final Ref ref;

  SplashContext(this.ref);
}

abstract class BootstrapTask {
  Future<void> execute(BootstrapContext context);
}

abstract class SplashTaskBase {}

abstract class SplashTask<Result> implements SplashTaskBase {
  Future<Result> execute(SplashContext context);
}

abstract class ReactiveSplashTask<WatchData, Result> implements SplashTaskBase {
  Future<WatchData> watch(Ref ref);

  Future<Result> execute(SplashContext context, WatchData watchedData);
}

abstract class OneTimeSplashTask extends SplashTask<DisposalCallback?> {}

typedef ReactiveTask<WatchData> = ReactiveSplashTask<WatchData, DisposalCallback?>;

typedef ReactiveDataTask<WatchData, Result> = ReactiveSplashTask<WatchData, Result>;

typedef SimpleReactiveTask<T> = ReactiveSplashTask<T, DisposalCallback?>;

typedef MultiReactiveTask<T1, T2> = ReactiveSplashTask<(T1, T2), DisposalCallback?>;

typedef TripleReactiveTask<T1, T2, T3> = ReactiveSplashTask<(T1, T2, T3), DisposalCallback?>;

typedef QuadReactiveTask<T1, T2, T3, T4> = ReactiveSplashTask<(T1, T2, T3, T4), DisposalCallback?>;
