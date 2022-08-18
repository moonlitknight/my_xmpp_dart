import 'dart:async';
import 'package:universal_io/io.dart';

XmppWebSocket createSocket() {
  throw UnsupportedError('No implementation of the connect api provided');
}

bool isTlsRequired() {
  throw UnsupportedError('No implementation of the connect api provided');
}

abstract class XmppWebSocket extends Stream<String> {
  /// webSocketPath /ws for ejabberd, /ws-xmpp for mongooseim
  Future<XmppWebSocket> connect<S>(String host, int port, String webSocketPath,
      {String Function(String event)? map});

  void write(Object? message);

  void close();

  Future<SecureSocket?> secure(
      {host,
      SecurityContext? context,
      bool Function(X509Certificate certificate)? onBadCertificate,
      List<String>? supportedProtocols});
}
