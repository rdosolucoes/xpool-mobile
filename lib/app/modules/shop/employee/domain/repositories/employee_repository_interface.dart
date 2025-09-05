import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../entities/employee_entity.dart';

abstract class IEmployeeRepository {
  Future<Either<Failure, List<EmployeeEntity>>> get();
  Future<Either<Failure, ResultModel>> saveEmployee(EmployeeEntity request);
  Future<Either<Failure, ResultModel>> deleteEmployee(int id);
}
