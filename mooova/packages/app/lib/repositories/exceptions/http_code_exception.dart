class HttpCodeException implements Exception {
  final int code;

  const HttpCodeException({
    required this.code,
  });

  @override
  String toString() => "HttpCodeException($code)";
}
