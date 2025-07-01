/// Base exception class for all app exceptions
abstract class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Exception for validation errors
class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// Exception for business logic errors
class BusinessException extends AppException {
  const BusinessException(super.message);
}

/// Exception for storage/cache errors
class StorageException extends AppException {
  const StorageException(super.message);
}

/// Exception for navigation errors
class NavigationException extends AppException {
  const NavigationException(super.message);
}

/// Exception for feature not implemented
class NotImplementedException extends AppException {
  const NotImplementedException([super.message = 'Feature not implemented yet']);
}