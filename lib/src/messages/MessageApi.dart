import '../../xmpp_stone.dart';

abstract class MessageApi {
  /// Send a simple message. See also [Chat.sendMessage]
  /// @param [Jid] to as a Jid
  /// @param text
  /// @paam [MessageStanzaType] optional message type enum (chat, groupchat, etc)
  void sendMessage(Jid to, String text, MessageStanzaType? messageType);
}
