import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sok_chea_sihanouk_clinic/exports.dart';
import 'package:sok_chea_sihanouk_clinic/src/features/auth/auth.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  const signInParam = SignInParam(email: 'email', password: 'password');
  final mockUserId = AuthUserId.fromValue('');

  group('Sign in provider', () {
    test('update authStateProvider to authenticated when sign in success', () async {
      final mockAuthRepo = MockAuthRepo();

      //Arrange
      when(() => mockAuthRepo.currentId()).thenAnswer((_) async => right(const None()));
      when(() => mockAuthRepo.signIn(signInParam)).thenAnswer((_) async => right(mockUserId));

      final container = createContainer(
        overrides: [
          authRepoProvider.overrideWithValue(mockAuthRepo),
        ],
      );
      final listener = RiverListener<AsyncValue<AuthenticationState>>();
      container.listen(authStateProvider, listener, fireImmediately: true);

      //Act
      await container.read(signInProvider.notifier).call(signInParam);
      final signInState = container.read(signInProvider);
      final authState = await container.read(authStateProvider.future);

      //Assert

      expect(signInState.isSuccess, isTrue);
      expect(authState.whenOrNull(authenticated: id), isNotNull);
      verify(() => mockAuthRepo.currentId()).called(1);
      verify(() => mockAuthRepo.signIn(signInParam)).called(1);
      verifyNoMoreInteractions(mockAuthRepo);
    });

    test('unauthenticated when sign in fail', () async {
      final mockAuthRepo = MockAuthRepo();

      //Arrange
      when(() => mockAuthRepo.currentId()).thenAnswer((_) async => right(const None()));
      when(() => mockAuthRepo.signIn(signInParam))
          .thenAnswer((_) async => left(Failure.fromString('errorString')));

      final container = createContainer(
        overrides: [
          authRepoProvider.overrideWithValue(mockAuthRepo),
        ],
      );
      final listener = RiverListener<AsyncValue<AuthenticationState>>();
      container.listen(authStateProvider, listener, fireImmediately: true);

      //Act
      await container.read(signInProvider.notifier).call(signInParam);
      final signInState = container.read(signInProvider);
      final authState = await container.read(authStateProvider.future);

      //Assert

      expect(signInState.isSuccess, isFalse);
      expect(authState.whenOrNull(authenticated: id), isNull);
      verify(() => mockAuthRepo.currentId()).called(1);
      verify(() => mockAuthRepo.signIn(signInParam)).called(1);
      verifyNoMoreInteractions(mockAuthRepo);
    });
  });
}
