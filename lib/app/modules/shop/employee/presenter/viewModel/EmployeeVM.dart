import 'package:flutter/foundation.dart';

import '../../domain/entities/employee_entity.dart';

@immutable
class EmployeeVM {
  final List<EmployeeEntity> employees;
  final int id;
  final String name;
  final String login;
  final String password;

  EmployeeVM(
      {this.employees = const <EmployeeEntity>[],
      this.id = 0,
      this.login = '',
      this.password = '',
      this.name = ''});

  EmployeeVM copyWith({
    List<EmployeeEntity>? employees,
    int? id,
    String? name,
    String? login,
    String? password,
  }) {
    return EmployeeVM(
      employees: employees ?? this.employees,
      id: id ?? this.id,
      login: login ?? this.login,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
