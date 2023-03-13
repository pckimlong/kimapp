import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sok_chea_sihanouk_clinic/exports.dart';
import 'package:sok_chea_sihanouk_clinic/src/features/auth/auth.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  group('Sign out provider', () {
    test('switch from authenticated to unauthenticated when sign out success', () async {
      final mockAuthRepo = MockAuthRepo();
      final mockUserId = AuthUserId.fromValue('');
      when(() => mockAuthRepo.signOut()).thenAnswer((_) async => right(unit));
      when(() => mockAuthRepo.currentId()).thenAnswer((_) async => right(Option.of(mockUserId)));

      //Arrange
      final container = createContainer(
        overrides: [
          authRepoProvider.overrideWithValue(mockAuthRepo),
        ],
      );
      final listener = RiverListener<AsyncValue<AuthenticationState>>();
      container.listen(authStateProvider, listener, fireImmediately: true);

      //Act
      await container.read(signOutProvider.notifier).call();
      final signOutState = container.read(signOutProvider);

      //Assert
      expect(signOutState.isSuccess, isTrue);
      verifyInOrder([
        () => listener(
              null,
              const AsyncValue.loading(),
            ),
        () => listener(
              const AsyncValue.loading(),
              AsyncValue.data(AuthenticationState.authenticated(mockUserId)),
            ),
        () => listener(
              AsyncValue.data(AuthenticationState.authenticated(mockUserId)),
              const AsyncValue.data(AuthenticationState.unauthenticated()),
            ),
      ]);
    });

    test('No sign out if any reason sign out fail', () async {
      final mockAuthRepo = MockAuthRepo();
      final mockUserId = AuthUserId.fromValue('');
      when(() => mockAuthRepo.signOut())
          .thenAnswer((_) async => left(Failure.fromString('errorString')));
      when(() => mockAuthRepo.currentId()).thenAnswer((_) async => right(Option.of(mockUserId)));

      //Arrange
      final container = createContainer(
        overrides: [
          authRepoProvider.overrideWithValue(mockAuthRepo),
        ],
      );
      final listener = RiverListener<AsyncValue<AuthenticationState>>();
      container.listen(authStateProvider, listener, fireImmediately: true);

      //Act
      await container.read(signOutProvider.notifier).call();
      final signOutState = container.read(signOutProvider);

      //Assert
      expect(signOutState.isFailure, isTrue);
      verifyInOrder([
        () => listener(
              null,
              const AsyncValue.loading(),
            ),
        () => listener(
              const AsyncValue.loading(),
              AsyncValue.data(AuthenticationState.authenticated(mockUserId)),
            ),
      ]);
    });
  });
}
