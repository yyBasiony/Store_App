import 'package:store_app_api/presentation/auth/base/controller.dart';

abstract class Validation {
  String? _validate(String value);

  String? validateAll(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field can't be empty";
    }
    return _validate(value);
  }

  static Validation fromLabel(String label, AuthController controller) {
    print("Validating field: '$label'");

    return switch (label.trim()) {
      "FirstName" => FirstNameValidation(),
      "LastName" => LastNameValidation(),
      "Email" => EmailValidation(),
      "Phone" => PhoneValidation(),
      "Password" => PasswordValidation(),
      "Confirm Password" =>
        ConfirmPasswordValidation(() => controller.getFieldValue("Password")),
      _ => throw ArgumentError("Unknown Field: $label"),
    };
  }
}

class FirstNameValidation extends Validation {
  @override
  String? _validate(String value) {
    final firstNameRegex = RegExp(r"^[A-Z][a-z]*$");
    return firstNameRegex.hasMatch(value)
        ? null
        : "First name must start with a capital letter";
  }
}

class LastNameValidation extends Validation {
  @override
  String? _validate(String value) {
    final lastNameRegex = RegExp(r"^[A-Z][a-z]*$");
    return lastNameRegex.hasMatch(value)
        ? null
        : "Last name must start with a capital letter";
  }
}

class EmailValidation extends Validation {
  @override
  String? _validate(String value) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(value) ? null : "Please enter a valid email";
  }
}

class PasswordValidation extends Validation {
  @override
  String? _validate(String value) {
    value = value.trim();

    final strongPasswordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    return strongPasswordRegex.hasMatch(value)
        ? null
        : "Password must have at least 8 characters, one uppercase, one lowercase, one number, and one special character";
  }
}

class ConfirmPasswordValidation extends Validation {
  final String Function() getPassword;

  ConfirmPasswordValidation(this.getPassword);

  @override
  String? _validate(String value) {
    final password = getPassword();
    return value == password ? null : "Passwords do not match";
  }
}

class PhoneValidation extends Validation {
  @override
  String? _validate(String value) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(value)
        ? null
        : "Please enter a valid phone number";
  }
}
