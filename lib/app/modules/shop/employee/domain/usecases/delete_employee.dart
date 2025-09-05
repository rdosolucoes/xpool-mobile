import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/employee_repository_interface.dart';
import 'interface/delete_employee_interface.dart';

class DeleteEmployee implements IDeleteEmployee {
  final IEmployeeRepository _employRepository;

  DeleteEmployee(this._employRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int id) async {
    try {
      return _employRepository.deleteEmployee(id);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar funcionário');
    }
  }
}
