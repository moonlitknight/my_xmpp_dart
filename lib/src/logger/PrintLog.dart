import 'Log.dart';

class PrintLog implements Log {
  void log(String s) {
    print(s);
  }

  LogLevel logLevel = LogLevel.VERBOSE;

  bool logXmpp = true;

  void v(String tag, String message) {
    if (logLevel.index <= LogLevel.VERBOSE.index) {
      log('V/[$tag]: $message');
    }
  }

  void d(String tag, String message) {
    if (logLevel.index <= LogLevel.DEBUG.index) {
      log('D/[$tag]: $message');
    }
  }

  void i(String tag, String message) {
    if (logLevel.index <= LogLevel.INFO.index) {
      log('I/[$tag]: $message');
    }
  }

  void w(String tag, String message) {
    if (logLevel.index <= LogLevel.WARNING.index) {
      log('W/[$tag]: $message');
    }
  }

  void e(String tag, String message) {
    if (logLevel.index <= LogLevel.ERROR.index) {
      log('E/[$tag]: $message');
    }
  }

  void xmppp_receiving(String message) {
    /* if (message.startsWith('<a')) { */
    /*   return; */
    /* } */
    /* if (message.startsWith('<r')) { */
    /*   return; */
    /* } */
    if (logXmpp) {
      log('\u001b[38:5:15m<<< \u001b[38:5:11m$message');
    }
  }

  void xmppp_sending(String message) {
    /* if (message.startsWith('<a')) { */
    /*   return; */
    /* } */
    /* if (message.startsWith('<r')) { */
    /*   return; */
    /* } */
    if (logXmpp) {
      log('\u001b[38:5:15m>>> \u001b[38:5:2m$message');
    }
  }
}

