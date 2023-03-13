import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sok_chea_sihanouk_clinic/exports.dart';
import 'package:sok_chea_sihanouk_clinic/src/features/auth/auth.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  group(
    'auth_state_provider',
    () {
      test('authenticated state when has user id from repository', () async {
        final mockAuthRepo = MockAuthRepo();
        final mockUserId = AuthUserId.fromValue('');

        //Arrange
        when(() => mockAuthRepo.currentId()).thenAnswer((_) async => right(Option.of(mockUserId)));

        final container = createContainer(
          overrides: [authRepoProvider.overrideWithValue(mockAuthRepo)],
        );

        final listener = RiverListener<AsyncValue<AuthenticationState>>();

        container.listen<AsyncValue<AuthenticationState>>(
          authStateProvider,
          listener,
          fireImmediately: true,
        );

        //Act
        await container.read(authStateProvider.future);

        //Assert
        verifyInOrder([
          () => listener(null, const AsyncValue.loading()),
          () => listener(
                const AsyncValue.loading(),
                AsyncValue.data(AuthenticationState.authenticated(mockUserId)),
              ),
        ]);

        verify(() => mockAuthRepo.currentId()).called(1);
        verifyNoMoreInteractions(mockAuthRepo);
      });

      test('unauthenticated state when has no user id from repository', () async {
        final mockAuthRepo = MockAuthRepo();

        //Arrange
        when(() => mockAuthRepo.currentId()).thenAnswer((_) async => right(const None()));

        final container = createContainer(
          overrides: [authRepoProvider.overrideWithValue(mockAuthRepo)],
        );

        final listener = RiverListener<AsyncValue<AuthenticationState>>();

        container.listen<AsyncValue<AuthenticationState>>(
          authStateProvider,
          listener,
          fireImmediately: true,
        );

        //Act
        await container.read(authStateProvider.future);

        //Assert

        verifyInOrder([
          () => listener(null, const AsyncValue.loading()),
          () => listener(
                const AsyncValue.loading(),
                const AsyncValue.data(AuthenticationState.unauthenticated()),
              ),
        ]);

        verify(() => mockAuthRepo.currentId()).called(1);
        verifyNoMoreInteractions(mockAuthRepo);
      });
    },
  );
}
