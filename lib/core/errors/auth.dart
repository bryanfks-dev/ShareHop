import 'package:sharehop/core/errors/app.dart';

class AuthenticateUserFailed extends AppError {
  new() : super(message: 'Authenticate user failed');
}
