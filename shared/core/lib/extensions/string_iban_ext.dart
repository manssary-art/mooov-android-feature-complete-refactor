part of 'string_ext.dart';

extension IBANStringExt on String {
  bool get isValidIban => replaceAll(' ', '').length > 3 && _isValidIban(this);
}

bool _isValidIban(String _iban, {bool sanitize = true}) {
  var iban = sanitize ? _iban.replaceAll(' ', '').toUpperCase() : _iban;
  if (iban.length < 2) return false;
  var spec = _specifications[iban.substring(0, 2)];
  return spec != null && spec.isValid(iban);
}

/// A list of all known IBAN specifications.
const Map<String, _Specification> _specifications = {
  'AD': _Specification(
      'AD', 24, 'F04F04A12', 'AD1200012030200359100100', r'^AD[0-9]{2}([0-9]{04})([0-9]{04})([0-9A-Za-z]{12})$'),
  'AE': _Specification('AE', 23, 'F03F16', 'AE070331234567890123456', r'^AE[0-9]{2}([0-9]{03})([0-9]{16})$'),
  'AL': _Specification('AL', 28, 'F08A16', 'AL47212110090000000235698741', r'^AL[0-9]{2}([0-9]{08})([0-9A-Za-z]{16})$'),
  'AT': _Specification('AT', 20, 'F05F11', 'AT611904300234573201', r'^AT[0-9]{2}([0-9]{05})([0-9]{11})$'),
  'AZ': _Specification('AZ', 28, 'U04A20', 'AZ21NABZ00000000137010001944', r'^AZ[0-9]{2}([A-Z]{04})([0-9A-Za-z]{20})$'),
  'BA': _Specification(
      'BA', 20, 'F03F03F08F02', 'BA391290079401028494', r'^BA[0-9]{2}([0-9]{03})([0-9]{03})([0-9]{08})([0-9]{02})$'),
  'BE': _Specification('BE', 16, 'F03F07F02', 'BE68539007547034', r'^BE[0-9]{2}([0-9]{03})([0-9]{07})([0-9]{02})$'),
  'BG': _Specification('BG', 22, 'U04F04F02A08', 'BG80BNBG96611020345678',
      r'^BG[0-9]{2}([A-Z]{04})([0-9]{04})([0-9]{02})([0-9A-Za-z]{08})$'),
  'BH': _Specification('BH', 22, 'U04A14', 'BH67BMAG00001299123456', r'^BH[0-9]{2}([A-Z]{04})([0-9A-Za-z]{14})$'),
  'BR': _Specification('BR', 29, 'F08F05F10U01A01', 'BR9700360305000010009795493P1',
      r'^BR[0-9]{2}([0-9]{08})([0-9]{05})([0-9]{10})([A-Z]{01})([0-9A-Za-z]{01})$'),
  'BY': _Specification('BY', 28, 'A04F04A16', 'BY13NBRB3600900000002Z00AB00',
      r'^BY[0-9]{2}([0-9A-Za-z]{04})([0-9]{04})([0-9A-Za-z]{16})$'),
  'CH': _Specification('CH', 21, 'F05A12', 'CH9300762011623852957', r'^CH[0-9]{2}([0-9]{05})([0-9A-Za-z]{12})$'),
  'CR': _Specification('CR', 22, 'F04F14', 'CR72012300000171549015', r'^CR[0-9]{2}([0-9]{04})([0-9]{14})$'),
  'CY': _Specification(
      'CY', 28, 'F03F05A16', 'CY17002001280000001200527600', r'^CY[0-9]{2}([0-9]{03})([0-9]{05})([0-9A-Za-z]{16})$'),
  'CZ': _Specification(
      'CZ', 24, 'F04F06F10', 'CZ6508000000192000145399', r'^CZ[0-9]{2}([0-9]{04})([0-9]{06})([0-9]{10})$'),
  'DE': _Specification('DE', 22, 'F08F10', 'DE89370400440532013000', r'^DE[0-9]{2}([0-9]{08})([0-9]{10})$'),
  'DK': _Specification('DK', 18, 'F04F09F01', 'DK5000400440116243', r'^DK[0-9]{2}([0-9]{04})([0-9]{09})([0-9]{01})$'),
  'DO': _Specification('DO', 28, 'U04F20', 'DO28BAGR00000001212453611324', r'^DO[0-9]{2}([A-Z]{04})([0-9]{20})$'),
  'EE': _Specification(
      'EE', 20, 'F02F02F11F01', 'EE382200221020145685', r'^EE[0-9]{2}([0-9]{02})([0-9]{02})([0-9]{11})([0-9]{01})$'),
  'EG': _Specification(
      'EG', 29, 'F04F04F17', 'EG800002000156789012345180002', r'^EG[0-9]{2}([0-9]{04})([0-9]{04})([0-9]{17})$'),
  'ES': _Specification('ES', 24, 'F04F04F01F01F10', 'ES9121000418450200051332',
      r'^ES[0-9]{2}([0-9]{04})([0-9]{04})([0-9]{01})([0-9]{01})([0-9]{10})$'),
  'FI': _Specification('FI', 18, 'F06F07F01', 'FI2112345600000785', r'^FI[0-9]{2}([0-9]{06})([0-9]{07})([0-9]{01})$'),
  'FO': _Specification('FO', 18, 'F04F09F01', 'FO6264600001631634', r'^FO[0-9]{2}([0-9]{04})([0-9]{09})([0-9]{01})$'),
  'FR': _Specification('FR', 27, 'F05F05A11F02', 'FR1420041010050500013M02606',
      r'^FR[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'GB':
      _Specification('GB', 22, 'U04F06F08', 'GB29NWBK60161331926819', r'^GB[0-9]{2}([A-Z]{04})([0-9]{06})([0-9]{08})$'),
  'GE': _Specification('GE', 22, 'U02F16', 'GE29NB0000000101904917', r'^GE[0-9]{2}([A-Z]{02})([0-9]{16})$'),
  'GI': _Specification('GI', 23, 'U04A15', 'GI75NWBK000000007099453', r'^GI[0-9]{2}([A-Z]{04})([0-9A-Za-z]{15})$'),
  'GL': _Specification('GL', 18, 'F04F09F01', 'GL8964710001000206', r'^GL[0-9]{2}([0-9]{04})([0-9]{09})([0-9]{01})$'),
  'GR': _Specification(
      'GR', 27, 'F03F04A16', 'GR1601101250000000012300695', r'^GR[0-9]{2}([0-9]{03})([0-9]{04})([0-9A-Za-z]{16})$'),
  'GT': _Specification(
      'GT', 28, 'A04A20', 'GT82TRAJ01020000001210029690', r'^GT[0-9]{2}([0-9A-Za-z]{04})([0-9A-Za-z]{20})$'),
  'HR': _Specification('HR', 21, 'F07F10', 'HR1210010051863000160', r'^HR[0-9]{2}([0-9]{07})([0-9]{10})$'),
  'HU': _Specification('HU', 28, 'F03F04F01F15F01', 'HU42117730161111101800000000',
      r'^HU[0-9]{2}([0-9]{03})([0-9]{04})([0-9]{01})([0-9]{15})([0-9]{01})$'),
  'IE':
      _Specification('IE', 22, 'U04F06F08', 'IE29AIBK93115212345678', r'^IE[0-9]{2}([A-Z]{04})([0-9]{06})([0-9]{08})$'),
  'IL': _Specification(
      'IL', 23, 'F03F03F13', 'IL620108000000099999999', r'^IL[0-9]{2}([0-9]{03})([0-9]{03})([0-9]{13})$'),
  'IS': _Specification('IS', 26, 'F04F02F06F10', 'IS140159260076545510730339',
      r'^IS[0-9]{2}([0-9]{04})([0-9]{02})([0-9]{06})([0-9]{10})$'),
  'IT': _Specification('IT', 27, 'U01F05F05A12', 'IT60X0542811101000000123456',
      r'^IT[0-9]{2}([A-Z]{01})([0-9]{05})([0-9]{05})([0-9A-Za-z]{12})$'),
  'IQ': _Specification(
      'IQ', 23, 'U04F03A12', 'IQ98NBIQ850123456789012', r'^IQ[0-9]{2}([A-Z]{04})([0-9]{03})([0-9A-Za-z]{12})$'),
  'JO':
      _Specification('JO', 30, 'A04F22', 'JO15AAAA1234567890123456789012', r'^JO[0-9]{2}([0-9A-Za-z]{04})([0-9]{22})$'),
  'KW':
      _Specification('KW', 30, 'U04A22', 'KW81CBKU0000000000001234560101', r'^KW[0-9]{2}([A-Z]{04})([0-9A-Za-z]{22})$'),
  'KZ': _Specification('KZ', 20, 'F03A13', 'KZ86125KZT5004100100', r'^KZ[0-9]{2}([0-9]{03})([0-9A-Za-z]{13})$'),
  'LB': _Specification('LB', 28, 'F04A20', 'LB62099900000001001901229114', r'^LB[0-9]{2}([0-9]{04})([0-9A-Za-z]{20})$'),
  'LC': _Specification('LC', 32, 'U04F24', 'LC07HEMM000100010012001200013015', r'^LC[0-9]{2}([A-Z]{04})([0-9]{24})$'),
  'LI': _Specification('LI', 21, 'F05A12', 'LI21088100002324013AA', r'^LI[0-9]{2}([0-9]{05})([0-9A-Za-z]{12})$'),
  'LT': _Specification('LT', 20, 'F05F11', 'LT121000011101001000', r'^LT[0-9]{2}([0-9]{05})([0-9]{11})$'),
  'LU': _Specification('LU', 20, 'F03A13', 'LU280019400644750000', r'^LU[0-9]{2}([0-9]{03})([0-9A-Za-z]{13})$'),
  'LV': _Specification('LV', 21, 'U04A13', 'LV80BANK0000435195001', r'^LV[0-9]{2}([A-Z]{04})([0-9A-Za-z]{13})$'),
  'MC': _Specification('MC', 27, 'F05F05A11F02', 'MC5811222000010123456789030',
      r'^MC[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'MD': _Specification('MD', 24, 'U02A18', 'MD24AG000225100013104168', r'^MD[0-9]{2}([A-Z]{02})([0-9A-Za-z]{18})$'),
  'ME':
      _Specification('ME', 22, 'F03F13F02', 'ME25505000012345678951', r'^ME[0-9]{2}([0-9]{03})([0-9]{13})([0-9]{02})$'),
  'MK': _Specification(
      'MK', 19, 'F03A10F02', 'MK07250120000058984', r'^MK[0-9]{2}([0-9]{03})([0-9A-Za-z]{10})([0-9]{02})$'),
  'MR': _Specification('MR', 27, 'F05F05F11F02', 'MR1300020001010000123456753',
      r'^MR[0-9]{2}([0-9]{05})([0-9]{05})([0-9]{11})([0-9]{02})$'),
  'MT': _Specification(
      'MT', 31, 'U04F05A18', 'MT84MALT011000012345MTLCAST001S', r'^MT[0-9]{2}([A-Z]{04})([0-9]{05})([0-9A-Za-z]{18})$'),
  'MU': _Specification('MU', 30, 'U04F02F02F12F03U03', 'MU17BOMM0101101030300200000MUR',
      r'^MU[0-9]{2}([A-Z]{04})([0-9]{02})([0-9]{02})([0-9]{12})([0-9]{03})([A-Z]{03})$'),
  'NL': _Specification('NL', 18, 'U04F10', 'NL91ABNA0417164300', r'^NL[0-9]{2}([A-Z]{04})([0-9]{10})$'),
  'NO': _Specification('NO', 15, 'F04F06F01', 'NO9386011117947', r'^NO[0-9]{2}([0-9]{04})([0-9]{06})([0-9]{01})$'),
  'PK': _Specification('PK', 24, 'U04A16', 'PK36SCBL0000001123456702', r'^PK[0-9]{2}([A-Z]{04})([0-9A-Za-z]{16})$'),
  'PL': _Specification('PL', 28, 'F08F16', 'PL61109010140000071219812874', r'^PL[0-9]{2}([0-9]{08})([0-9]{16})$'),
  'PS':
      _Specification('PS', 29, 'U04A21', 'PS92PALS000000000400123456702', r'^PS[0-9]{2}([A-Z]{04})([0-9A-Za-z]{21})$'),
  'PT': _Specification('PT', 25, 'F04F04F11F02', 'PT50000201231234567890154',
      r'^PT[0-9]{2}([0-9]{04})([0-9]{04})([0-9]{11})([0-9]{02})$'),
  'QA':
      _Specification('QA', 29, 'U04A21', 'QA30AAAA123456789012345678901', r'^QA[0-9]{2}([A-Z]{04})([0-9A-Za-z]{21})$'),
  'RO': _Specification('RO', 24, 'U04A16', 'RO49AAAA1B31007593840000', r'^RO[0-9]{2}([A-Z]{04})([0-9A-Za-z]{16})$'),
  'RS':
      _Specification('RS', 22, 'F03F13F02', 'RS35260005601001611379', r'^RS[0-9]{2}([0-9]{03})([0-9]{13})([0-9]{02})$'),
  'SA': _Specification('SA', 24, 'F02A18', 'SA0380000000608010167519', r'^SA[0-9]{2}([0-9]{02})([0-9A-Za-z]{18})$'),
  'SC': _Specification('SC', 31, 'U04F04F16U03', 'SC18SSCB11010000000000001497USD',
      r'^SC[0-9]{2}([A-Z]{04})([0-9]{04})([0-9]{16})([A-Z]{03})$'),
  'SE': _Specification(
      'SE', 24, 'F03F16F01', 'SE4550000000058398257466', r'^SE[0-9]{2}([0-9]{03})([0-9]{16})([0-9]{01})$'),
  'SI': _Specification('SI', 19, 'F05F08F02', 'SI56263300012039086', r'^SI[0-9]{2}([0-9]{05})([0-9]{08})([0-9]{02})$'),
  'SK': _Specification(
      'SK', 24, 'F04F06F10', 'SK3112000000198742637541', r'^SK[0-9]{2}([0-9]{04})([0-9]{06})([0-9]{10})$'),
  'SM': _Specification('SM', 27, 'U01F05F05A12', 'SM86U0322509800000000270100',
      r'^SM[0-9]{2}([A-Z]{01})([0-9]{05})([0-9]{05})([0-9A-Za-z]{12})$'),
  'ST': _Specification(
      'ST', 25, 'F08F11F02', 'ST68000100010051845310112', r'^ST[0-9]{2}([0-9]{08})([0-9]{11})([0-9]{02})$'),
  'SV': _Specification('SV', 28, 'U04F20', 'SV62CENR00000000000000700025', r'^SV[0-9]{2}([A-Z]{04})([0-9]{20})$'),
  'TL': _Specification(
      'TL', 23, 'F03F14F02', 'TL380080012345678910157', r'^TL[0-9]{2}([0-9]{03})([0-9]{14})([0-9]{02})$'),
  'TN': _Specification('TN', 24, 'F02F03F13F02', 'TN5910006035183598478831',
      r'^TN[0-9]{2}([0-9]{02})([0-9]{03})([0-9]{13})([0-9]{02})$'),
  'TR': _Specification(
      'TR', 26, 'F05F01A16', 'TR330006100519786457841326', r'^TR[0-9]{2}([0-9]{05})([0-9]{01})([0-9A-Za-z]{16})$'),
  'UA': _Specification('UA', 29, 'F25', 'UA511234567890123456789012345', r'^UA[0-9]{2}([0-9]{25})$'),
  'VA': _Specification('VA', 22, 'F18', 'VA59001123000012345678', r'^VA[0-9]{2}([0-9]{18})$'),
  'VG': _Specification('VG', 24, 'U04F16', 'VG96VPVG0000012345678901', r'^VG[0-9]{2}([A-Z]{04})([0-9]{16})$'),
  'XK': _Specification('XK', 20, 'F04F10F02', 'XK051212012345678906', r'^XK[0-9]{2}([0-9]{04})([0-9]{10})([0-9]{02})$'),
  'AO': _Specification('AO', 25, 'F21', 'AO69123456789012345678901', r'^AO[0-9]{2}([0-9]{21})$'),
  'BF': _Specification('BF', 27, 'F23', 'BF2312345678901234567890123', r'^BF[0-9]{2}([0-9]{23})$'),
  'BI': _Specification('BI', 16, 'F12', 'BI41123456789012', r'^BI[0-9]{2}([0-9]{12})$'),
  'BJ': _Specification('BJ', 28, 'F24', 'BJ39123456789012345678901234', r'^BJ[0-9]{2}([0-9]{24})$'),
  'CI': _Specification('CI', 28, 'U02F22', 'CI70CI1234567890123456789012', r'^CI[0-9]{2}([A-Z]{02})([0-9]{22})$'),
  'CM': _Specification('CM', 27, 'F23', 'CM9012345678901234567890123', r'^CM[0-9]{2}([0-9]{23})$'),
  'CV': _Specification('CV', 25, 'F21', 'CV30123456789012345678901', r'^CV[0-9]{2}([0-9]{21})$'),
  'DZ': _Specification('DZ', 24, 'F20', 'DZ8612345678901234567890', r'^DZ[0-9]{2}([0-9]{20})$'),
  'IR': _Specification('IR', 26, 'F22', 'IR861234568790123456789012', r'^IR[0-9]{2}([0-9]{22})$'),
  'MG': _Specification('MG', 27, 'F23', 'MG1812345678901234567890123', r'^MG[0-9]{2}([0-9]{23})$'),
  'ML': _Specification('ML', 28, 'U01F23', 'ML15A12345678901234567890123', r'^ML[0-9]{2}([A-Z]{01})([0-9]{23})$'),
  'MZ': _Specification('MZ', 25, 'F21', 'MZ25123456789012345678901', r'^MZ[0-9]{2}([0-9]{21})$'),
  'SN': _Specification('SN', 28, 'U01F23', 'SN52A12345678901234567890123', r'^SN[0-9]{2}([A-Z]{01})([0-9]{23})$'),
  'GF': _Specification('GF', 27, 'F05F05A11F02', 'GF121234512345123456789AB13',
      r'^GF[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'GP': _Specification('GP', 27, 'F05F05A11F02', 'GP791234512345123456789AB13',
      r'^GP[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'MQ': _Specification('MQ', 27, 'F05F05A11F02', 'MQ221234512345123456789AB13',
      r'^MQ[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'RE': _Specification('RE', 27, 'F05F05A11F02', 'RE131234512345123456789AB13',
      r'^RE[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'PF': _Specification('PF', 27, 'F05F05A11F02', 'PF281234512345123456789AB13',
      r'^PF[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'TF': _Specification('TF', 27, 'F05F05A11F02', 'TF891234512345123456789AB13',
      r'^TF[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'YT': _Specification('YT', 27, 'F05F05A11F02', 'YT021234512345123456789AB13',
      r'^YT[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'NC': _Specification('NC', 27, 'F05F05A11F02', 'NC551234512345123456789AB13',
      r'^NC[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'BL': _Specification('BL', 27, 'F05F05A11F02', 'BL391234512345123456789AB13',
      r'^BL[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'MF': _Specification('MF', 27, 'F05F05A11F02', 'MF551234512345123456789AB13',
      r'^MF[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'PM': _Specification('PM', 27, 'F05F05A11F02', 'PM071234512345123456789AB13',
      r'^PM[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$'),
  'WF': _Specification('WF', 27, 'F05F05A11F02', 'WF621234512345123456789AB13',
      r'^WF[0-9]{2}([0-9]{05})([0-9]{05})([0-9A-Za-z]{11})([0-9]{02})$')
};

/// Create a new Specification for a valid IBAN number.
class _Specification {
  /// The code of the country.
  final String countryCode;

  /// The correct length of an IBAN of this country.
  final int length;

  /// The structure of the underlying BBAN (for validation and formatting)
  final String structure;

  /// An example of a valid IBAN
  final String example;

  /// A regular expression which matches valid IBANs.  The checksum however
  /// will of course not be checked.
  final String regexDef;

  /// Constructor
  const _Specification(this.countryCode, this.length, this.structure, this.example, this.regexDef);

  /// Check if the passed iban is valid according to this specification.
  bool isValid(String iban) {
    var regex = RegExp(regexDef);
    return length == iban.length &&
        countryCode == iban.substring(0, 2) &&
        regex.hasMatch(iban) &&
        _mod97(_iso13616Prepare(iban), onError: (_) => -1) == 1;
  }
}

var _a = 'A'.codeUnitAt(0);
var _z = 'Z'.codeUnitAt(0);

/// Prepare an IBAN for mod 97 computation by moving the first 4 chars to the end and transforming the letters to
/// numbers (A = 10, B = 11, ..., Z = 35), as specified in ISO13616.
String _iso13616Prepare(String _iban) {
  var iban = _iban.toUpperCase();
  iban = iban.substring(4) + iban.substring(0, 4);

  return iban.split('').map((n) {
    var code = n.codeUnitAt(0);
    if (code >= _a && code <= _z) {
// A = 10, B = 11, ... Z = 35
      return '${code - _a + 10}';
    } else {
      return n;
    }
  }).join();
}

/// Calculates the MOD 97 10 of the passed IBAN as specified in ISO7064.
///
/// If the [source] is not a valid positive integer literal, the [onError]
/// is called with the [source] as argument, and its return value is used
/// instead. If no [onError] is provided, a [FormatException] is thrown.
///
/// The [onError] handler can be chosen to return for instance `-1`.
/// This is preferable to throwing and then immediately catching the
/// [FormatException].
///
/// Example:
///     var value = int.parse(text, onError: (source) => -1);
///     if (value == -1) ... handle the problem
int _mod97(String source, {int Function(String source)? onError}) {
  if (source.trim().startsWith('-')) {
    if (onError != null) {
      return onError(source);
    }
    throw const FormatException('Only positive numbers are allowed.');
  }

  final parseF = onError == null ? int.parse : int.tryParse;

  String remainder = source;
  String block;

  while (remainder.length > 2) {
    block = remainder.length < 9 ? remainder : remainder.substring(0, 9);
    final parsedBlock = parseF(block);
    if (parsedBlock == null) {
      return onError!(source);
    }
    remainder = '${parsedBlock % 97}${remainder.substring(block.length)}';
  }

  final parsedRemainder = parseF(remainder);
  if (parsedRemainder == null) {
    return onError!(source);
  }
  return parsedRemainder % 97;
}
