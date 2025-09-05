import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../datasource/auth_datasource.dart';
import '../models/result_model.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  Future<Either<Failure, bool>> validateEmail(String code) async {
    try {
      var result = await _dataSource.validateEmail(code);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, bool>> sendCodeVerify(
      String email, String name, String phone) async {
    try {
      var result = await _dataSource.sendCodeVerify(email, name, phone);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, ResultModel>> validateForm(
      String name, String email, String phone) async {
    try {
      var result = await _dataSource.validateForm(name, email, phone);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }
}
