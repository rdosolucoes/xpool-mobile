import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../../domain/entities/reference_sup_entity.dart';
import '../../../domain/repositories/reference_sup_repository_interface.dart';
import '../datasources/reference_sup_datasource_interface.dart';

class ReferenceSupRepository implements IReferenceSupRepository {
  final IReferenceSupDataSource _datasource;

  ReferenceSupRepository(this._datasource);

  @override
  Future<Either<Failure, List<ReferenceSupEntity>>> get() async {
    try {
      var result = <ReferenceSupEntity>[];
      var listReferenceSup = await _datasource.get();

      result = listReferenceSup
          .map((e) => ReferenceSupEntity(
              id: e.id,
              userOrig: e.userOrig,
              urlLogo: e.urlLogo,
              dateHour: e.dateHour,
              need: e.need,
              description: e.description,
              iconNeed: e.iconNeed,
              localMainText: e.localMainText,
              localSecondaryText: e.localSecondaryText,
              latitude: e.latitude,
              longitude: e.longitude,
              totalAccept: e.totalAccept,
              totalReference: e.totalReference,
              totalReject: e.totalReject))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultNotificationModel>> accept(
      int referenceId) async {
    try {
      var result = await _datasource.accept(referenceId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultNotificationModel>> reject(
      int referenceId) async {
    try {
      var result = await _datasource.reject(referenceId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
