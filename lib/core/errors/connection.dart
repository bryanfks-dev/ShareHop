import 'package:sharehop/core/errors/app.dart';

class GetConnectionFailedError extends AppError {
  new() : super(message: 'Failed to retrieve connection');
}

class CreateConnectionFailedError extends AppError {
  new() : super(message: 'Failed to create connection');
}

class UpdateConnectionFailedError extends AppError {
  new() : super(message: 'Failed to update connection');
}

class RemoveConnectionFailedError extends AppError {
  new() : super(message: 'Failed to remove connection');
}
