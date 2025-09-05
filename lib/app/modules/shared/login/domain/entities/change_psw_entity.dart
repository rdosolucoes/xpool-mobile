import 'package:flutter/foundation.dart';

import '../../../../../../shared/models/base_model.dart';

@immutable
class ChangePswEntity extends BaseModel {
  final String userName;
  final String password;
  final String confirmPassword;

  ChangePswEntity(
      {this.userName = "",
      this.password = "",
      this.confirmPassword = "",
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  String get validation {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return "Login ou Senha sem preenchimento.";
    }

    if (confirmPassword.isNotEmpty && confirmPassword != password) {
      return "Senhas estão diferentes.";
    }

    return "";
  }

  ChangePswEntity copyWith({
    String? userName,
    String? password,
    String? confirmPassword,
  }) {
    return ChangePswEntity(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
