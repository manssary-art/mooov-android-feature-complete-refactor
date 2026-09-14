abstract class postalCodePattern {
  static bool isValidPostalCode(
    String countryCode,
    String postalCode,
  ) {
    final regex = postalCodePatterns[countryCode.toUpperCase()];

    if (regex == null) return false;
    return regex.hasMatch(postalCode.trim().toUpperCase());
  }

  static String? getPostalCodeExample(String countryCode) {
    return postalCodeExamples[countryCode.toUpperCase()];
  }

  static final Map<String, RegExp> postalCodePatterns = {
    'SE': RegExp(r'^[1-9]\d{2}\s?\d{2}$'),
    'NO': RegExp(r'^[0-9]{4}$'),
    'NL': RegExp(r'^[1-9]\d{3}\s?[A-Z]{2}$'),
    'DE': RegExp(r'^[0-9]{5}$'),
    'FI': RegExp(r'^[0-9]{5}$'),
    'ES': RegExp(r'^[0-9]{5}$'),
    'GR': RegExp(r'^[1-9]\d{2}\s?\d{2}$'),
    'PT': RegExp(r'^[1-9]\d{3}-\d{3}$'),
  };

  static final Map<String, String> postalCodeExamples = {
    'SE': '123 45',
    'NO': '0150',
    'NL': '1012 JS',
    'DE': '10115',
    'FI': '00100',
    'ES': '28001',
    'GR': '105 58',
    'PT': '1000-001',
  };
}
