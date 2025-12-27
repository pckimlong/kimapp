import 'package:flutter_test/flutter_test.dart';
import 'package:kimapp/riverpod_helper.dart';
import 'package:riverpod/riverpod.dart';

class _VoidStatusNotifier extends Notifier<ProviderStatus<void>> {
  @override
  ProviderStatus<void> build() => const ProviderStatus.initial();
}

final _voidStatusProvider =
    NotifierProvider.autoDispose<_VoidStatusNotifier, ProviderStatus<void>>(
  _VoidStatusNotifier.new,
);

class _IntStatusState with ProviderStatusClassMixin<_IntStatusState, int> {
  @override
  final ProviderStatus<int> status;

  const _IntStatusState({this.status = const ProviderStatus.initial()});

  @override
  _IntStatusState updateStatus(ProviderStatus<int> newStatus) =>
      _IntStatusState(status: newStatus);
}

class _IntStatusNotifier extends Notifier<_IntStatusState> {
  @override
  _IntStatusState build() => const _IntStatusState();
}

final _intStatusProvider =
    NotifierProvider.autoDispose<_IntStatusNotifier, _IntStatusState>(
  _IntStatusNotifier.new,
);

void main() {
  test('perform calls onSuccess for ProviderStatus<void>', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    var didCall = false;
    await container.read(_voidStatusProvider.notifier).perform<void>(
          (_) async {},
          onSuccess: (_) => didCall = true,
        );

    expect(didCall, isTrue);
  });

  test('perform calls onSuccess for non-void type', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    int? success;
    await container.read(_intStatusProvider.notifier).perform<int>(
          (_) async => 123,
          onSuccess: (value) => success = value,
        );

    expect(success, 123);
  });
}
