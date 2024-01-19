/// {@template base_validator}
/// A validator that checks if the value is a valid or not.
/// {@endtemplate}
abstract class Validator<T> {
  /// {@macro base_validator}
  const Validator({required this.message});

  /// A message to show when the value is invalid.
  final String message;

  /// Validates the value.
  /// Returns `true` if the value is valid, `false` otherwise.
  bool isValid(T? value);
}

/// {@template required_validator}
/// Checks if the value is not null or empty.
/// {@endtemplate}
class RequiredValidator extends Validator<String?> {
  /// {@macro required_validator}
  RequiredValidator({String? message})
      : super(
          message: message ?? "This field is required",
        );

  @override
  bool isValid(String? value) => value != null && value.isNotEmpty;
}

/// {@template min_length_validator}
/// This validator check if the value has a minimum length of [minLength].
/// {@endtemplate}
class MinimumLengthValidator extends Validator<String?> {
  /// {@macro min_length_validator}
  MinimumLengthValidator({
    required this.minLength,
    String? message,
  }) : super(
          message: message ?? "Please enter at least $minLength characters.",
        );

  /// The minimum length of the value.
  final int minLength;

  @override
  bool isValid(String? value) => value != null && value.length >= minLength;
}

/// {@template max_length_validator}
/// This validator check if the value has a maximum length of [maxLength].
/// {@endtemplate}
class MaximumLengthValidator extends Validator<String?> {
  /// {@macro max_length_validator}
  MaximumLengthValidator({
    required this.maxLength,
    String? message,
  }) : super(
          message: message ?? "Please enter at most $maxLength characters.",
        );

  /// The maximum length of the value.
  final int maxLength;

  @override
  bool isValid(String? value) => value != null && value.length <= maxLength;
}

/// {@template min_value_validator}
/// This validator check if the value is greater than [minValue].
/// {@endtemplate}
class MinimumValueValidator extends Validator<String?> {
  /// {@macro min_value_validator}
  MinimumValueValidator({
    required this.minValue,
    String? message,
  }) : super(
          message: message ?? "Value should be greater than $minValue.",
        );

  /// The minimum value.
  final int minValue;

  @override
  bool isValid(String? value) =>
      value != null && int.parse(value ?? "0") >= minValue;
}

/// {@template max_value_validator}
/// This validator check if the value is less than [maxValue].
/// {@endtemplate}
class MaximumValueValidator extends Validator<String?> {
  /// {@macro max_value_validator}
  MaximumValueValidator({
    required this.maxValue,
    String? message,
  }) : super(
          message: message ?? "value should be less than $maxValue.",
        );

  /// The maximum length of the value.
  final int maxValue;

  @override
  bool isValid(String? value) =>
      value != null && int.parse(value ?? "0") <= maxValue;
}

/// {@template form_validator}
/// A form field validator that checks for multiple validation on the value.
/// {@endtemplate}
class FormValidator {
  /// {@macro form_validator}
  const FormValidator(this.validators);

  /// A list of [Validator]s.
  final List<Validator<dynamic>> validators;

  /// Validates the value by iterating through the [validators].
  String? call(String? value) {
    for (var validator in validators) {
      if (!validator.isValid(value)) {
        return validator.message;
      }
    }
    return null;
  }
}
