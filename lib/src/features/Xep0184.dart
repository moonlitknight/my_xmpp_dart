import 'package:xmpp_stone/xmpp_stone.dart';

class Xep0184 {
  late Connection connection;

  Xep0184(Connection connection) {
    this.connection = connection;
  }

  /// examines the children of the message stanza looking for an XEP-0184 request
  bool doesMessageHaveDRrequest(MessageStanza message) {
    var hasDRr = false;
    message.children.forEach((element) {
      print("--${element.name}------- ${element.getNameSpace()}");
      if ("request" == element.name &&
          "urn:xmpp:receipts" == element.getNameSpace()) {
        hasDRr = true;
      }
    });
    print("returngin $hasDRr");
    return hasDRr;
  }

  /// Send a XEP-0184 delivery receipt
  /// @param [Message] the incoming message we're receipting
  /* void sendDR(MessageStanza message); */
  void sendDR(MessageStanza message) {
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
    this.connection.writeStanza(dr);
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
