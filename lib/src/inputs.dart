import "package:kong/kong.dart";

/// Data used as input to create a new account.
class AccountCreationInput {
  /// Account's username
  String username;

  /// Account email address
  String email;

  /// Account master key
  String password;

  AccountCreationInput({required this.username, required this.email, required this.password});

  /// Serialize object to JSON
  Map<String, String> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  /// Validate input
  bool isValid() {
    // Validate username
    if (KongValidator.username(username) != null) {
      throw Exception(
          'InvalidUsernameException\n\n- Username cannot be empty\n- Username cannot be more than 15 characters long\n- Username cannot contain symbols expcept one _');
    }

    // Validate email
    if (KongValidator.email(email) != null) {
      throw Exception('InvalidEmailException\n\n- Invalid email');
    }

    // Validate password
    if (KongValidator.password(password) != null) {
      throw Exception('InvalidPasswordException\n\n- Password length should be 10 chartcers or more');
    }

    return true;
  }
}

/// Data used as input to create a new account.
class AccountLoginInput {
  /// Account's username
  String username;

  /// Account master key
  String password;

  AccountLoginInput({required this.username, required this.password});

  /// Serialize object to JSON
  Map<String, String> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  /// Validate input
  bool isValid() {
    // Validate username
    if (KongValidator.username(username) != null) {
      throw Exception(
          'InvalidUsernameException\n\n- Username cannot be empty\n- Username cannot be more than 15 characters long\n- Username cannot contain symbols expcept one _');
    }

    // Validate password
    if (KongValidator.password(password) != null) {
      throw Exception('InvalidPasswordException\n\n- Password length should be 10 chartcers or more');
    }

    return true;
  }
}
