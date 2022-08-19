import 'package:xmpp_stone/src/elements/stanzas/MessageStanza.dart';

import '../logger/Log.dart';

abstract class MessagesListener {
  late Log log;
  void onNewMessage(MessageStanza? message);
}
