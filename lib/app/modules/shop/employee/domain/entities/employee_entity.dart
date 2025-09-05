import '../../../../../../shared/models/base_model.dart';

class EmployeeEntity extends BaseModel {
  final int id;
  final String name;
  final String login;
  final String password;

  EmployeeEntity(
      {this.id = 0, this.name = '', this.login = '', this.password = ''});

  EmployeeEntity copyWith({
    int? id,
    String? name,
    String? login,
    String? password,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }

  String get validation {
    if (name.isEmpty || login.isEmpty || password.isEmpty) {
      return "* Preencha todos os campos para continuar.";
    }

    if (password.length < 6) {
      return "A senha deve ter no mínimo 6 caracteres";
    }

    return "";
  }
}
