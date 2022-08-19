abstract class Log {
  late LogLevel logLevel;

  bool logXmpp = true;

  void v(String tag, String message) {}

  void d(String tag, String message) {}

  void i(String tag, String message) {}

  void w(String tag, String message) {}

  void e(String tag, String message) {}

  void xmppp_receiving(String message) {}

  void xmppp_sending(String message) {}
}

enum LogLevel { VERBOSE, DEBUG, INFO, WARNING, ERROR, OFF }
