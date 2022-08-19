import 'dart:async';
import 'package:xmpp_stone/src/Connection.dart';

class ReconnectionManager {
  static const TAG = 'ReconnectionManager';

  late Connection _connection;
  bool isActive = false;
  int initialTimeout = 1000;
  int totalReconnections = 3;
  late int timeOutInMs;
  int counter = 0;
  Timer? timer;

  ReconnectionManager(Connection connection) {
    _connection = connection;
    _connection.connectionStateStream.listen(connectionStateHandler);
    initialTimeout = _connection.account.reconnectionTimeout;
    totalReconnections = _connection.account.totalReconnections;
    timeOutInMs = initialTimeout;
  }

  void connectionStateHandler(XmppConnectionState state) {
    if (state == XmppConnectionState.ForcefullyClosed) {
      _connection.log.d(TAG, 'Connection forcefully closed!'); //connection lost
      handleReconnection();
    } else if (state == XmppConnectionState.SocketOpening) {
      //do nothing
    } else if (state != XmppConnectionState.Reconnecting) {
      isActive = false;
      timeOutInMs = initialTimeout;
      counter = 0;
      if (timer != null) {
        timer!.cancel();
        timer = null;
      }
    }
  }

  void handleReconnection() {
    if (timer != null) {
      timer!.cancel();
    }
    if (counter < totalReconnections) {
      timer = Timer(Duration(milliseconds: timeOutInMs), _connection.reconnect);
      timeOutInMs += timeOutInMs;
      _connection.log
          .d(TAG, 'TimeOut is: $timeOutInMs reconnection counter $counter');
      counter++;
    } else {
      _connection.close();
    }
  }
}
