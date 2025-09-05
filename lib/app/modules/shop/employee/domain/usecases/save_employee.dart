import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../entities/employee_entity.dart';
import '../repositories/employee_repository_interface.dart';
import 'interface/save_employee_interface.dart';

class SaveEmployee implements ISaveEmployee {
  final IEmployeeRepository _employRepository;

  SaveEmployee(this._employRepository);

  @override
  Future<Either<Failure, ResultModel>> call(EmployeeEntity request) async {
    if (request.validation.isNotEmpty) {
      return Left(DefaultFailure(message: request.validation));
    }

    try {
      return _employRepository.saveEmployee(request);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar funcionário');
    }
  }
}
