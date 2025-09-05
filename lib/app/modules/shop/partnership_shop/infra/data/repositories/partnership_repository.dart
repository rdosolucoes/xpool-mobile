import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../../domain/repositories/partnership_repository_interface.dart';
import '../datasources/partnership_datasource.interface.dart';

class PartnershipRepository implements IPartnershipRepository {
  // final IPartnershipDatasource _datasource;

  final IPartnershipDatasource _datasource;

  PartnershipRepository(this._datasource);

  @override
  Future<Either<Failure, ResultNotificationModel>> post(int userSupId) async {
    try {
      var result = await _datasource.post(userSupId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> delete(int userSupId) async {
    try {
      var result = await _datasource.delete(userSupId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> breakPartner(int userSupId) async {
    try {
      var result = await _datasource.breakPartner(userSupId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
