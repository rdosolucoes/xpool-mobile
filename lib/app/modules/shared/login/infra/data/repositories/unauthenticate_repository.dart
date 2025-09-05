import 'package:dartz/dartz.dart';

import '../../../../../../../shared/auth/local_storage/interfaces/auth_repository_interface.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/repositories/unauthenticate_repository_interface.dart';
import '../datasources/authenticate_datasource_interface.dart';

class UnauthenticateRepository implements IUnauthenticateRepository {
  final IAuthLocalStorage _localStorage;
  final IAuthenticateDatasource _dataSource;

  UnauthenticateRepository(this._localStorage, this._dataSource);

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      await _dataSource.unauthenticate();
      _localStorage.clear();

      return Right(true);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelAccount() async {
    try {
      var result = await _dataSource.cancelAccount();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }
}
