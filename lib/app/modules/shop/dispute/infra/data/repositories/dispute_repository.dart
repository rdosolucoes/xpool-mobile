import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../../domain/entities/dispute_entity.dart';
import '../../../domain/repositories/dispute_repository_interface.dart';
import '../datasources/dispute_datasource_interface.dart';

class DisputeRepository implements IDisputeRepository {
  final IDisputeDataSource _disputeDataSource;

  DisputeRepository(this._disputeDataSource);

  @override
  Future<Either<Failure, DisputeEntity>> get(int supId, int referenceId) async {
    try {
      var result = await _disputeDataSource.get(supId, referenceId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultNotificationModel>> approve(
      int disputeId) async {
    try {
      var result = await _disputeDataSource.approve(disputeId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultNotificationModel>> disapprove(
      int disputeId, String message) async {
    try {
      var result = await _disputeDataSource.disapprove(disputeId, message);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
