import 'package:xml/xml.dart' as xml;
import '../elements/stanzas/IqStanza.dart';

class IqParser {
  static const TAG = 'IqParser';

  static IqStanza parseIqStanza(String? id, xml.XmlElement element) {
    var typeString = element.getAttribute('type');
    return IqStanza(id, _parseIqType(typeString));
  }

  static IqStanzaType _parseIqType(String? typeString) {
    if (typeString == null) {
      print('[$TAG], No type found for iq stanza');
      return IqStanzaType.INVALID;
    } else {
      switch (typeString) {
        case 'error':
          return IqStanzaType.ERROR;
        case 'set':
          return IqStanzaType.SET;
        case 'result':
          return IqStanzaType.RESULT;
        case 'get':
          return IqStanzaType.GET;
        case 'invalid':
          return IqStanzaType.INVALID;
        case 'timeout':
          return IqStanzaType.TIMEOUT;
      }
    }
    return IqStanzaType.INVALID;
  }
}
