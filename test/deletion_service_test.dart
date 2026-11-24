import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:table_talk/services/deletion_service.dart';

class _MockFirebaseAuth extends Mock implements FirebaseAuth {}

class _JsonResponseClient extends http.BaseClient {
  _JsonResponseClient(this.body, this.statusCode);

  final String body;
  final int statusCode;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return http.StreamedResponse(
      Stream<List<int>>.value(utf8.encode(body)),
      statusCode,
      request: request,
    );
  }
}

void main() {
  test('preserves the recent-login error code from the deletion API', () async {
    final service = DeletionService(
      auth: _MockFirebaseAuth(),
      client: _JsonResponseClient(
        '{"success":false,"error":"Sign in again.","code":"requires-recent-login","reference":"req-123"}',
        401,
      ),
      apiBase: Uri.parse('https://bitebrigade.vercel.app'),
      tokenProvider: () async => 'test-token',
    );
    addTearDown(service.close);

    await expectLater(
      service.deleteAccount('person@example.com'),
      throwsA(
        isA<DeletionFailure>()
            .having((failure) => failure.statusCode, 'statusCode', 401)
            .having(
              (failure) => failure.code,
              'code',
              'requires-recent-login',
            )
            .having(
              (failure) => failure.reference,
              'reference',
              'req-123',
            ),
      ),
    );
  });
}
