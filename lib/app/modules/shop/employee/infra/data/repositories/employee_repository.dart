import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../domain/entities/employee_entity.dart';
import '../../../domain/repositories/employee_repository_interface.dart';
import '../../models/employee_model.dart';
import '../datasources/employee_datasource_interface.dart';

class EmployeeRepository implements IEmployeeRepository {
  final IEmployeeDataSource _datasource;

  EmployeeRepository(this._datasource);

  @override
  Future<Either<Failure, List<EmployeeEntity>>> get() async {
    try {
      var result = await _datasource.get();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> saveEmployee(
      EmployeeEntity request) async {
    try {
      var model = EmployeeModel(
        id: request.id,
        name: request.name,
        login: request.login,
        password: request.password,
      );

      var result = await _datasource.save(model);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> deleteEmployee(int id) async {
    try {
      var result = await _datasource.delete(id);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
