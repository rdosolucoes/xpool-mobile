import 'dart:convert';

import '../../domain/entities/change_psw_entity.dart';

class ChangePswModel extends ChangePswEntity {
  ChangePswModel(
      {String password = "",
      String confirmPassword = "",
      String? messageError,
      bool? success})
      : super(
            password: password,
            confirmPassword: confirmPassword,
            messageError: messageError,
            success: success);

  factory ChangePswModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return ChangePswModel();

    return ChangePswModel(
      success: json['success'] ?? false,
    );
  }

  factory ChangePswModel.fromJson(String source) =>
      ChangePswModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  String toJson() => json.encode(toMap());
}
