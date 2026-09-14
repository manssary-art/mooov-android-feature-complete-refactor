final CardCollection _defaultCCTypes = CardCollection({
  _TYPE_VISA: CreditCardType.visa(),
  _TYPE_MASTERCARD: CreditCardType.mastercard(),
  _TYPE_AMEX: CreditCardType.americanExpress(),
  _TYPE_DISCOVER: CreditCardType.discover(),
  _TYPE_DINERS_CLUB: CreditCardType.dinersClub(),
  _TYPE_JCB: CreditCardType.jcb(),
  _TYPE_UNIONPAY: CreditCardType.unionPay(),
  _TYPE_MAESTRO: CreditCardType.maestro(),
  _TYPE_ELO: CreditCardType.elo(),
  _TYPE_HIPER: CreditCardType.hiper(),
  _TYPE_HIPERCARD: CreditCardType.hipercard(),
});

CardCollection _customCards = CardCollection.from(_defaultCCTypes);

/// Finds non numeric characters
RegExp _nonNumeric = RegExp(r'\D+');

/// Finds whitespace in any form
RegExp _whiteSpace = RegExp(r'\s+\b|\b\s');

/// This function determines the potential CC types based on the cardPatterns.
/// Returns a list of `CreditCardType`s with the most likely type as the first.
String? detectCCType(String? ccNumStr) {
  if (ccNumStr == null || ccNumStr.trim() == '') {
    return null;
  }

  List<CreditCardType> cardTypes = [];
  ccNumStr = ccNumStr.replaceAll(_whiteSpace, '');

  if (ccNumStr.isEmpty) {
    return _customCards.cards.values.toList().firstOrNull?.type;
  }

  // Check that only numerics are in the string
  if (_nonNumeric.hasMatch(ccNumStr)) {
    return cardTypes.firstOrNull?.type;
  }

  _customCards.cards.forEach(
    (String cardName, CreditCardType type) {
      for (Pattern pattern in type.patterns) {
        // Remove any spaces
        String ccPatternStr = ccNumStr!;
        int patternLen = pattern.prefixes[0].length;
        // Trim the CC number str to match the pattern prefix length
        if (patternLen < ccNumStr.length) {
          ccPatternStr = ccPatternStr.substring(0, patternLen);
        }

        if (pattern.prefixes.length > 1) {
          // Convert the prefix range into numbers then make sure the
          // CC num is in the pattern range.
          // Because Strings don't have '>=' type operators
          int ccPrefixAsInt = int.parse(ccPatternStr);
          int startPatternPrefixAsInt = int.parse(pattern.prefixes[0]);
          int endPatternPrefixAsInt = int.parse(pattern.prefixes[1]);
          if (ccPrefixAsInt >= startPatternPrefixAsInt && ccPrefixAsInt <= endPatternPrefixAsInt) {
            // Found a match
            type.matchStrength = _determineMatchStrength(
              ccNumStr,
              pattern.prefixes[0],
            );
            cardTypes.add(type);
            break;
          }
        } else {
          // Just compare the single pattern prefix with the CC prefix
          if (ccPatternStr == pattern.prefixes[0]) {
            // Found a match
            type.matchStrength = _determineMatchStrength(
              ccNumStr,
              pattern.prefixes[0],
            );
            cardTypes.add(type);
            break;
          }
        }
      }
    },
  );

  cardTypes.sort((a, b) => b.matchStrength.compareTo(a.matchStrength));
  return cardTypes.firstOrNull?.type;
}

int _determineMatchStrength(String ccNumStr, String patternPrefix) {
  if (ccNumStr.length >= patternPrefix.length) {
    return patternPrefix.length;
  } else {
    return 0;
  }
}

/// Gets the `CreditCardType` object associated with the `cardName`
CreditCardType? getCardType(String cardName) {
  return _customCards.getCardType(cardName);
}

/// Adds a custom card type to the card collection
///
/// Throws `Exception` if the `cardName` is already in the collection
void addCardType(String cardName, CreditCardType type) {
  _customCards.addCardType(cardName, type);
}

/// Updates the card type of the `cardName` in the card collection
void updateCardType(String cardName, CreditCardType type) {
  _customCards.updateCardType(cardName, type);
}

/// Removes `cardName` from the card collection
void removeCardType(String cardName) {
  CreditCardType? _ = _customCards.removeCard(cardName);
}

/// Resets the card collection to the default card types
void resetCardTypes() {
  _customCards = CardCollection.from(_defaultCCTypes);
}

/// Represents the credit card type and general information
/// about a particular brand of card, including the patterns and
/// usual security code used with that brand.
class CreditCardType {
  final String type;
  final String prettyType;
  final List<int> lengths;
  final Set<Pattern> patterns;
  SecurityCode securityCode;
  int matchStrength = 0;

  CreditCardType(this.type, this.prettyType, this.lengths, this.patterns, this.securityCode);

  /// Creates a Visa card type with default values
  CreditCardType.visa()
      : type = _TYPE_VISA,
        prettyType = _PRETTY_VISA,
        lengths = _ccNumLengthDefaults[_TYPE_VISA]!,
        patterns = _cardNumPatternDefaults[_TYPE_VISA]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_VISA]!;

  /// Creates a Mastercard card type with default values
  CreditCardType.mastercard()
      : type = _TYPE_MASTERCARD,
        prettyType = _PRETTY_MASTERCARD,
        lengths = _ccNumLengthDefaults[_TYPE_MASTERCARD]!,
        patterns = _cardNumPatternDefaults[_TYPE_MASTERCARD]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_MASTERCARD]!;

  /// Creates a American Express card type with default values
  CreditCardType.americanExpress()
      : type = _TYPE_AMEX,
        prettyType = _PRETTY_AMEX,
        lengths = _ccNumLengthDefaults[_TYPE_AMEX]!,
        patterns = _cardNumPatternDefaults[_TYPE_AMEX]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_AMEX]!;

  /// Creates a Discover card type with default values
  CreditCardType.discover()
      : type = _TYPE_DISCOVER,
        prettyType = _PRETTY_DISCOVER,
        lengths = _ccNumLengthDefaults[_TYPE_DISCOVER]!,
        patterns = _cardNumPatternDefaults[_TYPE_DISCOVER]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_DISCOVER]!;

  /// Creates a Diner's Club card type with default values
  CreditCardType.dinersClub()
      : type = _TYPE_DINERS_CLUB,
        prettyType = _PRETTY_DINERS_CLUB,
        lengths = _ccNumLengthDefaults[_TYPE_DINERS_CLUB]!,
        patterns = _cardNumPatternDefaults[_TYPE_DINERS_CLUB]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_DINERS_CLUB]!;

  /// Creates a JCB card type with default values
  CreditCardType.jcb()
      : type = _TYPE_JCB,
        prettyType = _PRETTY_JCB,
        lengths = _ccNumLengthDefaults[_TYPE_JCB]!,
        patterns = _cardNumPatternDefaults[_TYPE_JCB]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_JCB]!;

  /// Creates a UnionPay card type with default values
  CreditCardType.unionPay()
      : type = _TYPE_UNIONPAY,
        prettyType = _PRETTY_UNIONPAY,
        lengths = _ccNumLengthDefaults[_TYPE_UNIONPAY]!,
        patterns = _cardNumPatternDefaults[_TYPE_UNIONPAY]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_UNIONPAY]!;

  /// Creates a Maestro card type with default values
  CreditCardType.maestro()
      : type = _TYPE_MAESTRO,
        prettyType = _PRETTY_MAESTRO,
        lengths = _ccNumLengthDefaults[_TYPE_MAESTRO]!,
        patterns = _cardNumPatternDefaults[_TYPE_MAESTRO]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_MAESTRO]!;

  /// Creates a Elo card type with default values
  CreditCardType.elo()
      : type = _TYPE_ELO,
        prettyType = _PRETTY_ELO,
        lengths = _ccNumLengthDefaults[_TYPE_ELO]!,
        patterns = _cardNumPatternDefaults[_TYPE_ELO]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_ELO]!;

  /// Creates a Mir card type with default values
  CreditCardType.mir()
      : type = _TYPE_MIR,
        prettyType = _PRETTY_MIR,
        lengths = _ccNumLengthDefaults[_TYPE_MIR]!,
        patterns = _cardNumPatternDefaults[_TYPE_MIR]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_MIR]!;

  /// Creates a Hiper card type with default values
  CreditCardType.hiper()
      : type = _TYPE_HIPER,
        prettyType = _PRETTY_HIPER,
        lengths = _ccNumLengthDefaults[_TYPE_HIPER]!,
        patterns = _cardNumPatternDefaults[_TYPE_HIPER]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_HIPER]!;

  /// Creates a Hipercard card type with default values
  CreditCardType.hipercard()
      : type = _TYPE_HIPER,
        prettyType = _PRETTY_HIPER,
        lengths = _ccNumLengthDefaults[_TYPE_HIPER]!,
        patterns = _cardNumPatternDefaults[_TYPE_HIPER]!,
        securityCode = _ccSecurityCodeDefaults[_TYPE_HIPER]!;

  /// Add a new pattern to a card type
  void addPattern(Pattern pattern) {
    this.patterns.add(pattern);
  }

  /// Change the security code information about
  void updateSecurityCode(SecurityCode securityCode) {
    this.securityCode = securityCode;
  }

  @override
  bool operator ==(Object other) => (other is CreditCardType)
      ? (type == other.type &&
          prettyType == other.prettyType &&
          lengths == other.lengths &&
          patterns == other.patterns &&
          securityCode == other.securityCode)
      : false;

  @override
  int get hashCode => Object.hash(type, prettyType, lengths, patterns, securityCode);
}

/// Represents different patterns a credit card number pattern can have.
/// Mostly encapsulates the possible prefixes that the card number has for a particular brand.
class Pattern {
  /// A lower and upper bound on a range of values the card number starts with.
  /// i.e. `['51', '55']` represents the range of cards starting
  /// with '51' to those starting with '55'
  final List<String> prefixes;

  Pattern(this.prefixes);

  void addPrefix(String prefix) {
    prefixes.add(prefix);
  }

  @override
  bool operator ==(Object other) => (other is Pattern) ? (prefixes == other.prefixes) : false;

  @override
  int get hashCode => Object.hashAll(prefixes);
}

class SecurityCode {
  final String name;
  final int length;

  SecurityCode(this.name, this.length);

  /// Creates a security code based on a standard CVV
  const SecurityCode.cvv()
      : name = _SEC_CODE_CVV,
        length = _DEFAULT_SECURITY_CODE_LENGTH;

  /// Creates a security code based on a standard CVC
  const SecurityCode.cvc()
      : name = _SEC_CODE_CVC,
        length = _DEFAULT_SECURITY_CODE_LENGTH;

  /// Creates a security code based on a standard CID
  /// with 3 digits
  const SecurityCode.cid3()
      : name = _SEC_CODE_CID,
        length = _DEFAULT_SECURITY_CODE_LENGTH;

  /// Creates a security code based on a standard CID
  /// with 4 digits
  const SecurityCode.cid4()
      : name = _SEC_CODE_CID,
        length = _ALT_SECURITY_CODE_LENGTH;

  /// Creates a security code based on a standard CVN
  const SecurityCode.cvn()
      : name = _SEC_CODE_CVN,
        length = _DEFAULT_SECURITY_CODE_LENGTH;

  /// Creates a security code based on a standard CVE
  const SecurityCode.cve()
      : name = _SEC_CODE_CVE,
        length = _DEFAULT_SECURITY_CODE_LENGTH;

  /// Creates a security code based on a standard CVP2
  const SecurityCode.cvp2()
      : name = _SEC_CODE_CVP2,
        length = _DEFAULT_SECURITY_CODE_LENGTH;

  @override
  bool operator ==(Object other) => (other is SecurityCode) ? (name == other.name && length == other.length) : false;

  @override
  int get hashCode => Object.hash(name, length);
}

class CardCollection {
  final Map<String, CreditCardType> cards;

  CardCollection(this.cards);

  CardCollection.empty() : cards = {};

  factory CardCollection.from(CardCollection other) {
    CardCollection c = CardCollection.empty();
    c.cards.addAll(other.cards);
    return c;
  }

  CreditCardType? getCardType(String cardName) {
    return cards[cardName];
  }

  void addCardType(String key, CreditCardType cardType) {
    if (cards.containsKey(key)) {
      throw Exception('The card "${key}" already exists in this collection. Use `updateCardType()` instead');
    } else {
      cards[key] = cardType;
    }
  }

  void updateCardType(String key, CreditCardType cardType) {
    cards[key] = cardType;
  }

  CreditCardType? removeCard(String key) {
    return cards.remove(key);
  }
}

/// The default length of the CVV or security code (most cards do this)
const int _DEFAULT_SECURITY_CODE_LENGTH = 3;

/// The alternate length of the security code
const int _ALT_SECURITY_CODE_LENGTH = 4;

/// Predefined security code names
const String _SEC_CODE_CVV = 'CVV';
const String _SEC_CODE_CVC = 'CVC';
const String _SEC_CODE_CID = 'CID';
const String _SEC_CODE_CVN = 'CVN';
const String _SEC_CODE_CVE = 'CVE';
const String _SEC_CODE_CVP2 = 'CVP2';

/// Predefined card brands
const String _TYPE_VISA = 'visa';
const String _TYPE_MASTERCARD = 'mastercard';
const String _TYPE_AMEX = 'american_express';
const String _TYPE_DISCOVER = 'discover';
const String _TYPE_DINERS_CLUB = 'diners_club';
const String _TYPE_JCB = 'jcb';
const String _TYPE_UNIONPAY = 'unionpay';
const String _TYPE_MAESTRO = 'maestro';
const String _TYPE_ELO = 'elo';
const String _TYPE_MIR = 'mir';
const String _TYPE_HIPER = 'hiper';
const String _TYPE_HIPERCARD = 'hipercard';

/// Predefined pretty printed card brands
const String _PRETTY_VISA = 'Visa';
const String _PRETTY_MASTERCARD = 'Mastercard';
const String _PRETTY_AMEX = 'American Express';
const String _PRETTY_DISCOVER = 'Discover';
const String _PRETTY_DINERS_CLUB = 'Diner\'s Club';
const String _PRETTY_JCB = 'JCB';
const String _PRETTY_UNIONPAY = 'UnionPay';
const String _PRETTY_MAESTRO = 'Maestro';
const String _PRETTY_ELO = 'Elo';
const String _PRETTY_MIR = 'Mir';
const String _PRETTY_HIPER = 'Hiper';
const String _PRETTY_HIPERCARD = 'Hipercard';

/// A mapping of possible credit card types to their respective possible
/// card number length defaults
const Map<String, List<int>> _ccNumLengthDefaults = {
  _TYPE_VISA: const [16, 18, 19],
  _TYPE_MASTERCARD: const [16],
  _TYPE_AMEX: const [15],
  _TYPE_DISCOVER: const [16, 19],
  _TYPE_DINERS_CLUB: const [14, 16, 19],
  _TYPE_JCB: const [16, 17, 18, 19],
  _TYPE_UNIONPAY: const [14, 15, 16, 17, 18, 19],
  _TYPE_MAESTRO: const [12, 13, 14, 15, 16, 17, 18, 19],
  _TYPE_ELO: const [16],
  _TYPE_MIR: const [16, 17, 18, 19],
  _TYPE_HIPER: const [16],
  _TYPE_HIPERCARD: const [16],
};

/// A mapping of possible credit card types to their respective security code defaults
const Map<String, SecurityCode> _ccSecurityCodeDefaults = {
  _TYPE_VISA: const SecurityCode.cvv(),
  _TYPE_MASTERCARD: const SecurityCode.cvc(),
  _TYPE_AMEX: const SecurityCode.cid4(),
  _TYPE_DISCOVER: const SecurityCode.cid3(),
  _TYPE_DINERS_CLUB: const SecurityCode.cvv(),
  _TYPE_JCB: const SecurityCode.cvv(),
  _TYPE_UNIONPAY: const SecurityCode.cvn(),
  _TYPE_MAESTRO: const SecurityCode.cvc(),
  _TYPE_ELO: const SecurityCode.cve(),
  _TYPE_MIR: const SecurityCode.cvp2(),
  _TYPE_HIPER: const SecurityCode.cvc(),
  _TYPE_HIPERCARD: const SecurityCode.cvc(),
};

/// A [List<String>] represents a range.
/// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
Map<String, Set<Pattern>> _cardNumPatternDefaults = {
  _TYPE_VISA: {
    Pattern(const ['4'])
  },
  _TYPE_MASTERCARD: {
    Pattern(const ['51', '55']),
    Pattern(const ['2221', '2229']),
    Pattern(const ['223', '229']),
    Pattern(const ['23', '26']),
    Pattern(const ['270', '271']),
    Pattern(const ['2720']),
  },
  _TYPE_AMEX: {
    Pattern(const ['34']),
    Pattern(const ['37']),
  },
  _TYPE_DISCOVER: {
    Pattern(const ['6011']),
    Pattern(const ['644', '649']),
    Pattern(const ['65']),
  },
  _TYPE_DINERS_CLUB: {
    Pattern(const ['300', '305']),
    Pattern(const ['36']),
    Pattern(const ['38']),
    Pattern(const ['39']),
  },
  _TYPE_JCB: {
    Pattern(const ['3528', '3589']),
    Pattern(const ['2131']),
    Pattern(const ['1800']),
  },
  _TYPE_UNIONPAY: {
    Pattern(const ['620']),
    Pattern(const ['624', '626']),
    Pattern(const ['62100', '62182']),
    Pattern(const ['62184', '62187']),
    Pattern(const ['62185', '62197']),
    Pattern(const ['62200', '62205']),
    Pattern(const ['622010', '622999']),
    Pattern(const ['622018']),
    Pattern(const ['622019', '622999']),
    Pattern(const ['62207', '62209']),
    Pattern(const ['622126', '622925']),
    Pattern(const ['623', '626']),
    Pattern(const ['6270']),
    Pattern(const ['6272']),
    Pattern(const ['6276']),
    Pattern(const ['627700', '627779']),
    Pattern(const ['627781', '627799']),
    Pattern(const ['6282', '6289']),
    Pattern(const ['6291']),
    Pattern(const ['6292']),
    Pattern(const ['810']),
    Pattern(const ['8110', '8131']),
    Pattern(const ['8132', '8151']),
    Pattern(const ['8152', '8163']),
    Pattern(const ['8164', '8171']),
  },
  _TYPE_MAESTRO: {
    Pattern(const ['493698']),
    Pattern(const ['500000', '506698']),
    Pattern(const ['506779', '508999']),
    Pattern(const ['56', '59']),
    Pattern(const ['63']),
    Pattern(const ['67']),
  },
  _TYPE_ELO: {
    Pattern(const ['401178']),
    Pattern(const ['401179']),
    Pattern(const ['438935']),
    Pattern(const ['457631']),
    Pattern(const ['457632']),
    Pattern(const ['431274']),
    Pattern(const ['451416']),
    Pattern(const ['457393']),
    Pattern(const ['504175']),
    Pattern(const ['506699', '506778']),
    Pattern(const ['509000', '509999']),
    Pattern(const ['627780']),
    Pattern(const ['636297']),
    Pattern(const ['636368']),
    Pattern(const ['650031', '650033']),
    Pattern(const ['650035', '650051']),
    Pattern(const ['650405', '650439']),
    Pattern(const ['650485', '650538']),
    Pattern(const ['650541', '650598']),
    Pattern(const ['650700', '650718']),
    Pattern(const ['650720', '650727']),
    Pattern(const ['650901', '650978']),
    Pattern(const ['651652', '651679']),
    Pattern(const ['655000', '655019']),
    Pattern(const ['655021', '655058']),
  },
  _TYPE_MIR: {
    Pattern(const ['2200', '2204']),
  },
  _TYPE_HIPER: {
    Pattern(const ['637095']),
    Pattern(const ['637568']),
    Pattern(const ['637599']),
    Pattern(const ['637609']),
    Pattern(const ['637612']),
    Pattern(const ['63743358']),
    Pattern(const ['63737423']),
  },
  _TYPE_HIPERCARD: {
    Pattern(const ['606282']),
  },
};
