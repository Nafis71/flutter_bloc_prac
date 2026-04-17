import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

mixin PrettyLogger {
  static final Logger _logger = Logger(
    level: kDebugMode ? Level.debug : Level.off,
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  void debugLogger({required dynamic message, StackTrace? stackTrace}) {
    _logger.d(message, stackTrace: stackTrace);
  }

  void errorLogger({required dynamic message, StackTrace? stackTrace}) {
    _logger.e(message, stackTrace: stackTrace);
  }

  void infoLogger({required dynamic message, StackTrace? stackTrace}) {
    _logger.i(message, stackTrace: stackTrace);
  }

  void warningLogger({required dynamic message, StackTrace? stackTrace}) {
    _logger.w(message, stackTrace: stackTrace);
  }
}
