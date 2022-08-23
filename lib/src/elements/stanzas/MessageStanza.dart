import 'package:collection/collection.dart' show IterableExtension;
import 'package:xmpp_stone/src/elements/XmppAttribute.dart';
import 'package:xmpp_stone/src/elements/XmppElement.dart';
import 'package:xmpp_stone/src/elements/stanzas/AbstractStanza.dart';

import '../../data/Jid.dart';

class MessageStanza extends AbstractStanza {
  MessageStanzaType? type;

  MessageStanza(id, type) {
    name = 'message';
    this.id = id;
    this.type = type;
    addAttribute(
        XmppAttribute('type', type.toString().split('.').last.toLowerCase()));
  }

  /// alternative constructor to make a MessageStanza from an Element
  MessageStanza.fromXmppElement(XmppElement messageElement) {
    this.fromJid = Jid.fromFullJid(messageElement.getAttribute('from')!.value!);
    this.toJid = Jid.fromFullJid(messageElement.getAttribute('to')!.value!);
    this.id = messageElement.getAttribute('id') != null
        ? messageElement.getAttribute('id')!.value
        : null;
    this.body = messageElement.getChild('body') != null
        ? messageElement.getChild('body')!.textValue
        : null;
    var typeS = messageElement.getAttribute('type') != null
        ? messageElement.getAttribute('type')!.value
        : '';
    type = MessageStanzaType.NORMAL;
    // add any child elements
    for (var child in messageElement.children) {
      this.addChild(child);
    }
    try {
      type = MessageStanzaType.values.byName(typeS!.toUpperCase());
    } catch (e) {}
  }

  String? get body => children
      .firstWhereOrNull(
          (child) => (child.name == 'body' && child.attributes.isEmpty))
      ?.textValue;

  set body(String? value) {
    var element = XmppElement();
    element.name = 'body';
    element.textValue = value;
    addChild(element);
  }

  String? get subject => children
      .firstWhereOrNull((child) => (child.name == 'subject'))
      ?.textValue;

  set subject(String? value) {
    var element = XmppElement();
    element.name = 'subject';
    element.textValue = value;
    addChild(element);
  }

  String? get thread =>
      children.firstWhereOrNull((child) => (child.name == 'thread'))?.textValue;

  set thread(String? value) {
    var element = XmppElement();
    element.name = 'thread';
    element.textValue = value;
    addChild(element);
  }
}

enum MessageStanzaType {
  CHAT,
  ERROR,
  GROUPCHAT,
  HEADLINE,
  NORMAL,
  UNKOWN,
  DRRECEIVED
}
