import 'package:flutter_test/flutter_test.dart';
import 'package:sharehop/core/errors/app.dart';
import 'package:sharehop/core/errors/auth.dart';
import 'package:sharehop/core/errors/connection.dart';

void main() {
  group('AppError', () {
    test('AuthenticateUserFailed has expected message and toString', () {
      final error = AuthenticateUserFailed();
      expect(error.message, 'Authenticate user failed');
      expect(error.toString(), 'AppError: Authenticate user failed');
      expect(error, isA<AppError>());
      expect(error, isA<Exception>());
    });

    test('Connection errors have expected messages and toString', () {
      final getErr = GetConnectionFailedError();
      expect(getErr.message, 'Failed to retrieve connection');
      expect(getErr.toString(), 'AppError: Failed to retrieve connection');

      final createErr = CreateConnectionFailedError();
      expect(createErr.message, 'Failed to create connection');
      expect(createErr.toString(), 'AppError: Failed to create connection');

      final updateErr = UpdateConnectionFailedError();
      expect(updateErr.message, 'Failed to update connection');
      expect(updateErr.toString(), 'AppError: Failed to update connection');

      final removeErr = RemoveConnectionFailedError();
      expect(removeErr.message, 'Failed to remove connection');
      expect(removeErr.toString(), 'AppError: Failed to remove connection');
    });
  });
}
