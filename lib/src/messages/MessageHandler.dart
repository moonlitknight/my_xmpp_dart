import 'package:xmpp_stone/src/Connection.dart';
import 'package:xmpp_stone/src/data/Jid.dart';
import 'package:xmpp_stone/src/elements/stanzas/AbstractStanza.dart';
import 'package:xmpp_stone/src/elements/stanzas/MessageStanza.dart';
import 'package:xmpp_stone/src/messages/MessageApi.dart';

import '../features/Xep0184.dart';
import 'xmppMessageAttributes.dart';

class MessageHandler implements MessageApi {
  static Map<Connection, MessageHandler> instances = {};

  Stream<MessageStanza?> get messagesStream {
    return _connection.inStanzasStream
        .where((abstractStanza) => abstractStanza is MessageStanza)
        .map((stanza) => stanza as MessageStanza?);
  }

  /// factory method to return an instance of MessageHandler.
  /// either returns a previously created MessageHandler for this Connection, or creates a new one
  static MessageHandler getInstance(Connection connection) {
    var manager = instances[connection];
    if (manager == null) {
      manager = MessageHandler(connection);
      instances[connection] = manager;
    }

    return manager;
  }

  final Connection _connection;

  MessageHandler(this._connection);

  @override
  String sendMessage(Jid to, String text, {XmppMessageAttributes? attributes}) {
    attributes = attributes ?? new XmppMessageAttributes();
    return _sendMessageStanza(to, text, attributes);
  }

  String _sendMessageStanza(
      Jid jid, String text, XmppMessageAttributes attributes) {
    var stanza =
        MessageStanza(AbstractStanza.getRandomId(), attributes.messageType);
    stanza.toJid = jid;
    stanza.fromJid = _connection.fullJid;
    stanza.body = text;
    if (attributes.requestDR) {
      Xep0184.addDRrequest(stanza);
    }
    _connection.writeStanza(stanza);
    return stanza.id!;
  }
}
