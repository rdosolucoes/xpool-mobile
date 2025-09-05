import 'package:flutter/foundation.dart';

@immutable
class AuthenticateEntity {
  final String login;
  final String password;
  final String confirmPassword;
  final bool isSignUp;
  final int typeUser;
  final String name;
  final String? playerId;
  final bool emailValidate;
  final bool isEmployee;

  AuthenticateEntity(
      {required this.login,
      required this.password,
      this.confirmPassword = "",
      this.isSignUp = false,
      this.typeUser = 0,
      this.name = "",
      this.playerId = "",
      this.emailValidate = false,
      this.isEmployee = false});

  String get validation {
    if (login.isEmpty || password.isEmpty) {
      return "Login ou Senha sem preenchimento.";
    }

    if (isSignUp && confirmPassword.isNotEmpty && confirmPassword != password) {
      return "Senhas estão diferentes.";
    }

    if (isSignUp && confirmPassword.isEmpty) {
      return "Informe a confirmação da senha.";
    }

    if (password.length < 6) {
      return "A senha deve ter no mínimo 6 caracteres";
    }

    return "";
  }
}
