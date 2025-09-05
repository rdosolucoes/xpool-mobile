import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/employee_entity.dart';
import '../repositories/employee_repository_interface.dart';
import 'interface/get_employees_interface.dart';

class GetEmployees implements IGetEmployees {
  final IEmployeeRepository _employeeRepository;

  GetEmployees(this._employeeRepository);
  @override
  Future<Either<Failure, List<EmployeeEntity>>> call() async {
    var result = await _employeeRepository.get();

    return result;
  }
}
