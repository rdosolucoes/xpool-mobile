import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/usecases/delete_employee.dart';
import '../../domain/usecases/get_employees.dart';
import '../../domain/usecases/save_employee.dart';
import '../stores/employee_store.dart';

class EmployeeController {
  final EmployeeStore store;
  final GetEmployees _getEmployees;
  final SaveEmployee _saveEmployee;
  final DeleteEmployee _deleteEmployee;

  EmployeeController(this._getEmployees, this._saveEmployee,
      this._deleteEmployee, this.store) {
    getEmployees();
  }

  void setId(int v) => store.setId(v);
  void setName(String v) => store.setName(v);
  void setLogin(String v) => store.setLogin(v);
  void setPassword(String v) => store.setPassword(v);

  Future<void> getEmployees() async {
    store.setEmployees(_getEmployees());
  }

  void clearFields() {
    store.clear();
  }

  Future<void> saveEmployee() async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );

    try {
      asuka.addOverlay(overlay);
      await Future.delayed(Duration(seconds: 2));

      var isEdit = store.state.id > 0;

      var model = EmployeeEntity(
          id: store.state.id,
          name: store.state.name,
          login: store.state.login,
          password: store.state.password);

      var result = await _saveEmployee(model);

      result.fold((l) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(l.message ?? ""),
        ));
      }, (r) {
        Modular.to.pop();
        var msg = "Funcionário Incluído com Sucesso !";

        if (isEdit) {
          msg = "Alteração Realizada com Sucesso !";
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(msg),
        ));
        getEmployees();
      });
    } finally {
      overlay.remove();
    }
  }

  Future<void> deleteEmployee(int id) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );

    try {
      asuka.addOverlay(overlay);
      await Future.delayed(Duration(seconds: 2));

      var result = await _deleteEmployee(id);

      result.fold((l) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(l.message ?? ""),
        ));
      }, (r) {
        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Funcionário Excluído com Sucesso !"),
        ));
        getEmployees();
      });
    } finally {
      overlay.remove();
    }
  }
}
