/// Custom exception for API errors
class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.type = ApiExceptionType.unknown,
    this.data,
  });

  final String message;
  final int? statusCode;
  final ApiExceptionType type;
  final dynamic data;

  @override
  String toString() {
    return 'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }

  /// Check if the exception is due to network issues
  bool get isNetworkError {
    return type == ApiExceptionType.noConnection ||
           type == ApiExceptionType.timeout;
  }

  /// Check if the exception is due to authentication issues
  bool get isAuthError {
    return type == ApiExceptionType.unauthorized ||
           type == ApiExceptionType.forbidden;
  }

  /// Check if the exception is a client error (4xx)
  bool get isClientError {
    return statusCode != null && statusCode! >= 400 && statusCode! < 500;
  }

  /// Check if the exception is a server error (5xx)
  bool get isServerError {
    return statusCode != null && statusCode! >= 500;
  }

  /// Get user-friendly error message
  String get userMessage {
    switch (type) {
      case ApiExceptionType.noConnection:
        return 'No internet connection. Please check your network settings.';
      case ApiExceptionType.timeout:
        return 'Request timed out. Please try again.';
      case ApiExceptionType.unauthorized:
        return 'You are not authorized. Please login again.';
      case ApiExceptionType.forbidden:
        return 'You do not have permission to perform this action.';
      case ApiExceptionType.notFound:
        return 'The requested resource was not found.';
      case ApiExceptionType.badRequest:
        return 'Invalid request. Please check your input.';
      case ApiExceptionType.serverError:
        return 'Server error occurred. Please try again later.';
      case ApiExceptionType.cancelled:
        return 'Request was cancelled.';
      case ApiExceptionType.unknown:
        return message.isNotEmpty ? message : 'An unexpected error occurred.';
    }
  }
}

/// Types of API exceptions
enum ApiExceptionType {
  /// No internet connection
  noConnection,
  
  /// Request timeout
  timeout,
  
  /// 401 Unauthorized
  unauthorized,
  
  /// 403 Forbidden
  forbidden,
  
  /// 404 Not Found
  notFound,
  
  /// 400 Bad Request
  badRequest,
  
  /// 5xx Server Error
  serverError,
  
  /// Request cancelled
  cancelled,
  
  /// Unknown error
  unknown,
}