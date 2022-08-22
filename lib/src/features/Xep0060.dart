import 'package:xmpp_stone/xmpp_stone.dart';

/// partial implementation of XEP-0060 PubSub.
/// Specifically, just enough to implement ejabberd MUCpub
class Xep0060 {
  /// examines the children of the message stanza looking for an XEP-0184 request
  static bool doesMessageHaveDRrequest(MessageStanza message) {
    var hasDRr = false;
    message.children.forEach((element) {
      if ("request" == element.name &&
          "urn:xmpp:receipts" == element.getNameSpace()) {
        hasDRr = true;
      }
    });
    return hasDRr;
  }

  /// examines a message and returns an array of messages if it's a pubsub, null if not
  static List<MessageStanza>? isaPub(MessageStanza message) {
    List<MessageStanza> messages = [];
    var eventChild = message.getChild("event");
    if (eventChild != null &&
        eventChild.getAttribute("xmlns")!.value ==
            "http://jabber.org/protocol/pubsub#event") {
      List<XmppElement> items = eventChild.getChild('items')!.children;
      items.forEach((element) {
        messages
            .add(MessageStanza.fromXmppElement(element.getChild('message')!));
      });
      return messages;
    } else {
      return null;
    }
  }

  /// Send a XEP-0060 Subscription
  /// @param [Message] the incoming message we're receipting
  /* void sendDR(MessageStanza message); */
  void sendSubscription(Connection connection, MessageStanza message) {
    print(
        "in senddr ${message.getAttribute('id')} ${message.fromJid!.fullJid} ${message.toJid!.fullJid} ${message.id}");
    /* var id = message.messageStanza.getAttribute("ine commentd"); */
    /* var from = message.from; */
    /* var to = message.to; */
    MessageStanza dr = new MessageStanza(message.id! + "ack", null);
    dr.fromJid = message.toJid;
    dr.toJid = message.fromJid;
    var xep0184_received = new XmppElement();
    xep0184_received.name = "received";
    xep0184_received
        .addAttribute(new XmppAttribute("xmlns", "urn:xmpp:receipts"));
    xep0184_received.addAttribute(new XmppAttribute("id", message.id));
    dr.addChild(xep0184_received);
    connection.writeStanza(dr);
  }

  /* /// adds an XEP-0184 request DRR child <request xmlns='urn:xmpp:receipts'/> to the stanza */
  /* static void addDRrequest(MessageStanza stanza) { */
  /*   var requestChild = new XmppElement(); */
  /*   requestChild.name = "request"; */
  /*   requestChild.addAttribute(new XmppAttribute("xmlns", "urn:xmpp:receipts")); */
  /*   stanza.addChild(requestChild); */
  /* } */
}
/*
<message
    from='kingrichard@royalty.england.lit/throne'
    id='bi29sg183b4v'
    to='northumberland@shakespeare.lit/westminster'>
  <received xmlns='urn:xmpp:receipts' id='richard2-4.1.247'/>
</_sendMessageStanza
*/
