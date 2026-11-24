import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:table_talk/services/auth_service.dart';
import 'package:table_talk/services/deletion_service.dart';

class _MockFirebaseAuth extends Mock implements FirebaseAuth {}

class _MockUser extends Mock implements User {}

class _MockGoogleSignIn extends Mock implements GoogleSignIn {}

class _MockDeletionService extends Mock implements DeletionService {}

class _FakeAuthProvider extends Fake implements AuthProvider {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeAuthProvider());
  });

  group('AuthService email sign-in', () {
    test('explains when Firebase Authentication is not configured', () async {
      final auth = _MockFirebaseAuth();
      when(
        () => auth.signInWithEmailAndPassword(
          email: 'user@example.com',
          password: 'password',
        ),
      ).thenThrow(
        FirebaseAuthException(
          code: 'internal-error',
          message:
              'An internal error has occurred. [ CONFIGURATION_NOT_FOUND ]',
        ),
      );

      await expectLater(
        AuthService(auth: auth).signInWithEmail(
          email: 'user@example.com',
          password: 'password',
        ),
        throwsA(
          isA<AuthFailure>()
              .having((error) => error.code, 'code', 'configuration-not-found')
              .having(
                (error) => error.message,
                'message',
                contains(
                  'Enable Google and Email/Password sign-in',
                ),
              ),
        ),
      );
    });
  });

  test('web Google sign-in redirects when the browser blocks its popup',
      () async {
    final auth = _MockFirebaseAuth();
    final googleSignIn = _MockGoogleSignIn();

    when(() => auth.signInWithPopup(any())).thenThrow(
      FirebaseAuthException(code: 'popup-blocked'),
    );
    when(() => auth.signInWithRedirect(any())).thenAnswer((_) async {});

    final result = await AuthService(
      auth: auth,
      googleSignIn: googleSignIn,
      isWeb: true,
    ).signInWithGoogle();

    expect(result, isNull);
    verify(() => auth.signInWithPopup(any())).called(1);
    verify(() => auth.signInWithRedirect(any())).called(1);
  });

  test('deleteAccount keeps the session when the server fails', () async {
    final auth = _MockFirebaseAuth();
    final user = _MockUser();
    final googleSignIn = _MockGoogleSignIn();
    final deletionService = _MockDeletionService();

    when(() => auth.currentUser).thenReturn(user);
    when(() => deletionService.deleteAccount('person@example.com'))
        .thenThrow(const DeletionFailure(
      'The deletion request timed out.',
      statusCode: 504,
    ));
    when(() => googleSignIn.signOut()).thenAnswer((_) => Future.value(null));
    when(() => auth.signOut()).thenAnswer((_) async {});

    await expectLater(
      AuthService(
        auth: auth,
        googleSignIn: googleSignIn,
        deletionService: deletionService,
      ).deleteAccount(confirmation: 'person@example.com'),
      throwsA(isA<DeletionFailure>()),
    );

    verifyNever(() => googleSignIn.signOut());
    verifyNever(() => auth.signOut());
  });

  test('deleteAccount signs out after the server confirms deletion', () async {
    final auth = _MockFirebaseAuth();
    final user = _MockUser();
    final googleSignIn = _MockGoogleSignIn();
    final deletionService = _MockDeletionService();

    when(() => auth.currentUser).thenReturn(user);
    when(() => deletionService.deleteAccount('person@example.com'))
        .thenAnswer((_) async {});
    when(() => googleSignIn.signOut()).thenAnswer((_) => Future.value(null));
    when(() => auth.signOut()).thenAnswer((_) async {});

    await AuthService(
      auth: auth,
      googleSignIn: googleSignIn,
      deletionService: deletionService,
    ).deleteAccount(confirmation: 'person@example.com');

    verify(() => googleSignIn.signOut()).called(1);
    verify(() => auth.signOut()).called(1);
  });

  test('a stale deletion session asks the user to sign in again', () async {
    final auth = _MockFirebaseAuth();
    final user = _MockUser();
    final googleSignIn = _MockGoogleSignIn();
    final deletionService = _MockDeletionService();

    when(() => auth.currentUser).thenReturn(user);
    when(() => deletionService.deleteAccount('person@example.com'))
        .thenThrow(const DeletionFailure(
      'For security, sign in again before deleting your account.',
      statusCode: 401,
      code: 'requires-recent-login',
    ));
    when(() => googleSignIn.signOut()).thenAnswer((_) => Future.value(null));
    when(() => auth.signOut()).thenAnswer((_) async {});

    await expectLater(
      AuthService(
        auth: auth,
        googleSignIn: googleSignIn,
        deletionService: deletionService,
      ).deleteAccount(confirmation: 'person@example.com'),
      throwsA(
        isA<AuthFailure>()
            .having((error) => error.code, 'code', 'requires-recent-login'),
      ),
    );

    verify(() => googleSignIn.signOut()).called(1);
    verify(() => auth.signOut()).called(1);
  });
}
