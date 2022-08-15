/* import 'dart:developer'; */

class Log {
  static void log(String s) {
    print(s);
  }

  static LogLevel logLevel = LogLevel.VERBOSE;

  static bool logXmpp = true;

  static void v(String tag, String message) {
    if (logLevel.index <= LogLevel.VERBOSE.index) {
      log('V/[$tag]: $message');
    }
  }

  static void d(String tag, String message) {
    if (logLevel.index <= LogLevel.DEBUG.index) {
      log('D/[$tag]: $message');
    }
  }

  static void i(String tag, String message) {
    if (logLevel.index <= LogLevel.INFO.index) {
      log('I/[$tag]: $message');
    }
  }

  static void w(String tag, String message) {
    if (logLevel.index <= LogLevel.WARNING.index) {
      log('W/[$tag]: $message');
    }
  }

  static void e(String tag, String message) {
    if (logLevel.index <= LogLevel.ERROR.index) {
      log('E/[$tag]: $message');
    }
  }

  static void xmppp_receiving(String message) {
    if (message.startsWith('<a')) {
      return;
    }
    if (message.startsWith('<r')) {
      return;
    }
    if (logXmpp) {
      log('<<< \u001b[38:5:11m$message');
    }
  }

  static void xmppp_sending(String message) {
    if (message.startsWith('<a')) {
      return;
    }
    if (message.startsWith('<r')) {
      return;
    }
    if (logXmpp) {
      log('>>> \u001b[38:5:2m$message');
    }
  }
}

enum LogLevel { VERBOSE, DEBUG, INFO, WARNING, ERROR, OFF }

