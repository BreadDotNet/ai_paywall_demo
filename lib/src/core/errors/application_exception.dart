final class ApplicationException implements Exception {
  const ApplicationException({
    required this.userMessage,
    this.originalException,
    this.stackTrace,
    this.details = const {},
  });

  final String userMessage;
  final Object? originalException;
  final StackTrace? stackTrace;
  final Map<String, Object?> details;

  @override
  String toString() => userMessage;
}

final class UnknownException extends ApplicationException {
  const UnknownException({super.originalException, super.stackTrace})
    : super(userMessage: 'Something went wrong.');
}

final class ConfigException extends ApplicationException {
  const ConfigException({required super.userMessage, super.details});
}
