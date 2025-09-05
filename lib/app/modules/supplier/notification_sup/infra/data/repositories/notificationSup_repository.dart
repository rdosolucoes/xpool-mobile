import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../../domain/entities/notificationSup_entity.dart';
import '../../../domain/repositories/notificationSup_repository_interface.dart';
import '../datasources/notificationSup_datasource_interface.dart';

class NotificationSupRepository implements INotificationSupRepository {
  // final INotificationSupDatasource _datasource;

  final INotificationSupDatasource _datasource;

  NotificationSupRepository(this._datasource);

  @override
  Future<Either<Failure, List<NotificationSupEntity>>> get() async {
    try {
      var result = <NotificationSupEntity>[];
      var listNotificationSup = await _datasource.get();

      result = listNotificationSup
          .map((e) => NotificationSupEntity(
              id: e.id,
              type: e.type,
              status: e.status,
              name: e.name,
              message: e.message,
              cityState: e.cityState,
              dateHour: e.dateHour,
              photo: e.photo))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultNotificationModel>> confirm(
      int userSupId) async {
    try {
      var result = await _datasource.confirm(userSupId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultNotificationModel>> reject(int userSupId) async {
    try {
      var result = await _datasource.reject(userSupId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
