import 'package:xmpp_stone/src/data/Jid.dart';

import '../elements/stanzas/MessageStanza.dart';

abstract class MessageApi {
  void sendMessage(Jid to, String text, MessageStanzaType? messageType);
}
