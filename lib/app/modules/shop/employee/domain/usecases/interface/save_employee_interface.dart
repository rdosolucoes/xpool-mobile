import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../entities/employee_entity.dart';

abstract class ISaveEmployee {
  Future<Either<Failure, ResultModel>> call(EmployeeEntity request);
}
