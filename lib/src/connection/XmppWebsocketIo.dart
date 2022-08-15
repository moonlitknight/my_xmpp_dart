import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:xmpp_stone/src/connection/XmppWebsocketApi.dart';

export 'XmppWebsocketApi.dart';

XmppWebSocket createSocket() {
  return XmppWebSocketIo();
}

bool isTlsRequired() {
  return true;
}

class XmppWebSocketIo extends XmppWebSocket {
  Socket? _socket;
  late String Function(String event) _map;

  XmppWebSocketIo();

  @override
  Future<XmppWebSocket> connect<S>(String host, int port,
      {String Function(String event)? map}) async {
    print("XWS26 Connect $host $port");
    await Socket.connect(host, port).then((Socket socket) {
      print("XWS connected");
      _socket = socket;

      if (map != null) {
        _map = map;
      } else {
        _map = (element) => element;
      }
    });

    return Future.value(this);
  }

  @override
  void close() {
    _socket!.close();
  }

  @override
  void write(Object? message) {
    _socket!.write(message);
  }

  @override
  StreamSubscription<String> listen(void Function(String event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _socket!.cast<List<int>>().transform(utf8.decoder).map(_map).listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError);
  }

  @override
  Future<SecureSocket?> secure({
    host,
    SecurityContext? context,
    bool Function(X509Certificate certificate)? onBadCertificate,
    List<String>? supportedProtocols,
  }) async {
    SecureSocket socket = await SecureSocket.secure(
      _socket!,
      onBadCertificate: onBadCertificate,
    );
    // Overwrite previous socket, since calling SecureSocket.secure makes
    // previous socket unusable.
    _socket = socket;
    return socket;
  }

  @override
  Future<SecureSocket?> secureOLD(
      {host,
      SecurityContext? context,
      bool Function(X509Certificate certificate)? onBadCertificate,
      List<String>? supportedProtocols}) {
    return SecureSocket.secure(_socket!, onBadCertificate: onBadCertificate);
  }
}
