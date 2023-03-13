import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sok_chea_sihanouk_clinic/exports.dart';
import 'package:sok_chea_sihanouk_clinic/src/features/auth/auth.dart';
import 'package:sok_chea_sihanouk_clinic/src/presentation/app/app_widget.dart';

import '../../../mocks.dart';
import '../../../set_up.dart';
import '../../../utils.dart';

void main() {
  group('app widget ...', () {
    group('authGateWidget ...', () {
      testWidgets('show unauthenticated app widget when authStateProvider is unauthenticated',
          (tester) async {
        final mockAuthRepo = MockAuthRepo();
        when(() => mockAuthRepo.currentId()).thenAnswer((_) async => right(const None()));

        final container = createContainer(
          overrides: [authRepoProvider.overrideWithValue(mockAuthRepo)],
        );

        final authState = await container.read(authStateProvider.future);
        expect(authState.isAuthenticated, isFalse);

        await tester.pumpApp(
          const AuthGateWidget(),
          container: container,
        );

        expect(find.byType(AuthGateWidget), findsOneWidget);
        await tester.pump();
        expect(find.byType(UnauthenticatedAppWidget), findsOneWidget);
        expect(find.byType(AuthenticatedAppWidget), findsNothing);
      });

      testWidgets('show unauthenticated app widget when authStateProvider is authenticated',
          (tester) async {
        final mockAuthRepo = MockAuthRepo();
        when(() => mockAuthRepo.currentId())
            .thenAnswer((_) async => right(Some(AuthUserId.fromValue(''))));

        final container = createContainer(
          overrides: [authRepoProvider.overrideWithValue(mockAuthRepo)],
        );

        final authState = await container.read(authStateProvider.future);
        expect(authState.isAuthenticated, isTrue);

        await tester.pumpApp(
          const AuthGateWidget(),
          container: container,
        );

        expect(find.byType(AuthGateWidget), findsOneWidget);
        await tester.pump();
        expect(find.byType(UnauthenticatedAppWidget), findsNothing);
        expect(find.byType(AuthenticatedAppWidget), findsOneWidget);
      });
      testWidgets('turn from authenticated widget to unauthenticated widget when sign out',
          (tester) async {
        final mockAuthRepo = MockAuthRepo();
        when(() => mockAuthRepo.currentId())
            .thenAnswer((_) async => right(Some(AuthUserId.fromValue(''))));

        final container = createContainer(
          overrides: [authRepoProvider.overrideWithValue(mockAuthRepo)],
        );

        final isAuthenticated =
            await container.read(authStateProvider.selectAsync((data) => data.isAuthenticated));
        expect(isAuthenticated, isTrue);

        await tester.pumpApp(
          const AuthGateWidget(),
          container: container,
        );

        expect(find.byType(AuthGateWidget), findsOneWidget);

        container
            .read(authStateProvider.notifier)
            .updateAuthState(const AuthenticationState.unauthenticated());

        await tester.pump();
        expect(find.byType(UnauthenticatedAppWidget), findsOneWidget);
      });
    });
  });
}
