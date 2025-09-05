import 'package:dartz/dartz.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../../../shared/auth/local_storage/interfaces/auth_repository_interface.dart';
import '../../../../../../../shared/auth/models/auth_model.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/authenticate_entity.dart';
import '../../../domain/entities/change_psw_entity.dart';
import '../../../domain/errors/errors.dart';
import '../../../domain/repositories/authenticate_repository_interface.dart';
import '../../data/datasources/authenticate_datasource_interface.dart';
import '../../models/authenticate_model.dart';
import '../../models/change_psw_model.dart';

class AuthenticateRepository implements IAuthenticateRepository {
  final IAuthenticateDatasource _dataSource;
  final IAuthLocalStorage _localStorage;

  AuthenticateRepository(this._dataSource, this._localStorage);

  @override
  Future<Either<Failure, AuthModel>> authenticate(
      AuthenticateEntity request) async {
    var playerId = request.playerId;

    if (playerId == null || playerId == "") {
      var signalState = await OneSignal.shared.getDeviceState();
      playerId = signalState!.userId;
    }

    try {
      var auth = AuthenticateModel(
          login: request.login,
          password: request.password,
          isSignUp: request.isSignUp,
          playerId: playerId,
          emailValidate: request.emailValidate,
          isEmployee: request.isEmployee);

      final result = await _dataSource.authenticate(auth);

      _localStorage.add(result);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(AuthenticateRepostoryError(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> validateEmail(
      String userName, String code) async {
    try {
      var result = await _dataSource.validateEmail(userName, code);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendRememberPswEmail(String userName) async {
    try {
      var result = await _dataSource.sendRememberPswEmail(userName);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> rememberPassword(String userName) async {
    try {
      var result = await _dataSource.rememberPassword(userName);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ChangePswModel>> changePassword(
      ChangePswEntity pswEntity) async {
    try {
      var result = await _dataSource.changePassword(
          pswEntity.userName, pswEntity.password);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }
}
