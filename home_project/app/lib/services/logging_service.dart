import 'dart:developer' as developer;

class LoggingService {
  void logInfo(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: 'AppInfoLog', error: error, stackTrace: stackTrace);
  }

  void logWarning(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: 'AppWarningLog', level: 650, error: error, stackTrace: stackTrace);
  }

  void logError(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(message, name: 'AppErrorLog', level: 700, error: error, stackTrace: stackTrace);
  }

  // Add more logging levels and functions as needed
}