import 'package:xmpp_stone/xmpp_stone.dart';

class Xep0184 {
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

  /// examines a message and returns the original ID if it is a DRreceipt
  static String? isThisDrReceipt(MessageStanza message) {
    var child = message.getChild("received");
    if (child != null &&
        child.getAttribute("xmlns")!.value == "urn:xmpp:receipts") {
      return child.getAttribute("id")!.value;
    } else {
      return null;
    }
  }

  /// Send a XEP-0184 delivery receipt
  /// @param [Message] the incoming message we're receipting
  /* void sendDR(MessageStanza message); */
  void sendDR(Connection connection, MessageStanza message) {
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

  /// adds an XEP-0184 request DRR child <request xmlns='urn:xmpp:receipts'/> to the stanza
  static void addDRrequest(MessageStanza stanza) {
    var requestChild = new XmppElement();
    requestChild.name = "request";
    requestChild.addAttribute(new XmppAttribute("xmlns", "urn:xmpp:receipts"));
    stanza.addChild(requestChild);
  }
}
/*
<message
    from='kingrichard@royalty.england.lit/throne'
    id='bi29sg183b4v'
    to='northumberland@shakespeare.lit/westminster'>
  <received xmlns='urn:xmpp:receipts' id='richard2-4.1.247'/>
</_sendMessageStanza
*/
