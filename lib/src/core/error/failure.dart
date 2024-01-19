class Failure {
  final String code;
  final String message;
  final Object? object;

  const Failure({
    required this.code,
    required this.message,
    this.object,
  });

  @override
  String toString() =>
      'Failure{ code: $code, message: $message, object: $object,}';
}
