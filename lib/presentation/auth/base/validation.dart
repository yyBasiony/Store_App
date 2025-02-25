abstract class Validation {
  String? _validate(String value);

  String? validateAll(String? value) {
    if (value == null || value.isEmpty) {
      return "Field can't be empty";
    }

    return _validate(value);
  }

  static Validation fromLabel(String label, {String? password}) {
    return switch (label) {
      "FirstName" => FirstNameValidation(),
      "LastName" => LastNameValidation(),
      "Email" => EmailValidation(),
      "Phone" => PhoneValidation(),
      "Password" => PasswordValidation(),
      "Confirm Password" => ConfirmPasswordValidation(password),
      _ => throw ArgumentError("Unknown Field: $label"),
    };
  }
}

class FirstNameValidation extends Validation {
  @override
  String? _validate(String value) {
final firstNameRegex = RegExp(r"^[A-Z][a-zA-Z' ]*$");
    return firstNameRegex.hasMatch(value) ? null : "First name must start with a capital letter";
  }
}

class LastNameValidation extends Validation {
  @override
  String? _validate(String value) {
final lastNameRegex = RegExp(r"^[A-Z][a-zA-Z' ]*$");
    return lastNameRegex.hasMatch(value) ? null : "Last name must start with a capital letter";
  }
}


class EmailValidation extends Validation {
  @override
  String? _validate(String value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(value) ? null : "Please enter a valid email";
  }
}

class PhoneValidation extends Validation {
  @override
  String? _validate(String value) {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(value) ? null : "Please enter a valid phone number";
  }
}

class PasswordValidation extends Validation {
  @override
  String? _validate(String value) {
    final strongPasswordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$');
    return strongPasswordRegex.hasMatch(value)
        ? null
        : "Password must have at least 8 characters, one uppercase, one lowercase, one number, and one special character";
  }
}

class ConfirmPasswordValidation extends Validation {
  final String? password;
  ConfirmPasswordValidation(this.password);

  @override
  String? _validate(String value) {
    return value == password ? null : "Passwords don't match";
  }
}
