// ignore_for_file: constant_identifier_names

/// Set of failure codes that can be used for debugging.
class FailureCodes {
  FailureCodes._();

  /// When no internet is available.
  static const String NO_INTERNET = "0";

  /// When error or exception of unknown type is thrown.
  static const String UNKNOWN_ERROR = "1";

  /// When an assertion error is thrown.
  static const String ASSERTION_ERROR = "2";
}
