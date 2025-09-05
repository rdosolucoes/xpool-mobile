import 'dart:convert';

import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    int id = 0,
    String name = '',
    String login = '',
    String password = '',
  }) : super(id: id, name: name, login: login, password: password);

  factory EmployeeModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return EmployeeModel();

    return EmployeeModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        login: json['login'] ?? '',
        password: json['password'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'login': login,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
