import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/employee_repository_interface.dart';
import 'domain/usecases/delete_employee.dart';
import 'domain/usecases/get_employees.dart';
import 'domain/usecases/interface/delete_employee_interface.dart';
import 'domain/usecases/interface/get_employees_interface.dart';
import 'domain/usecases/interface/save_employee_interface.dart';
import 'domain/usecases/save_employee.dart';
import 'infra/data/datasources/employee_datasource_interface.dart';
import 'infra/data/repositories/employee_repository.dart';
import 'infra/external/datasources/employee_datasource.dart';
import 'presenter/pages/employee_controller.dart';
import 'presenter/pages/employee_page.dart';
import 'presenter/stores/employee_store.dart';

class EmployeeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EmployeeStore()),
    Bind.lazySingleton((i) => EmployeeController(i(), i(), i(), i())),
    Bind.lazySingleton<IEmployeeRepository>((i) => EmployeeRepository(i())),
    Bind.lazySingleton<IEmployeeDataSource>((i) => EmployeeDataSource(i())),
    Bind.lazySingleton<IGetEmployees>((i) => GetEmployees(i())),
    Bind.lazySingleton<ISaveEmployee>((i) => SaveEmployee(i())),
    Bind.lazySingleton<IDeleteEmployee>((i) => DeleteEmployee(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => EmployeePage()),
  ];
}
