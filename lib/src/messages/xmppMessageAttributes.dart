import '../elements/stanzas/MessageStanza.dart';

/// an extensible struct of attributes - this is pure XMPP . Higher level attributes are possible by extending the class in a higher level
class XmppMessageAttributes {
  MessageStanzaType messageType = MessageStanzaType.NORMAL;
  bool requestDR = false;
}
