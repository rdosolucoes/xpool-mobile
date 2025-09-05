import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/employee_entity.dart';

abstract class IGetEmployees {
  Future<Either<Failure, List<EmployeeEntity>>> call();
}
