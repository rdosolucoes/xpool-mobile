import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../../domain/entities/notificationShop_entity.dart';
import '../../../domain/repositories/notificationShop_repository_interface.dart';
import '../datasources/notificationShop_datasource_interface.dart';

class NotificationShopRepository implements INotificationShopRepository {
  // final INotificationShopDatasource _datasource;

  final INotificationShopDatasource _datasource;

  NotificationShopRepository(this._datasource);

  @override
  Future<Either<Failure, List<NotificationShopEntity>>> get() async {
    try {
      var result = <NotificationShopEntity>[];
      var listNotificationShop = await _datasource.get();

      result = listNotificationShop
          .map((e) => NotificationShopEntity(
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
      int userShopId) async {
    try {
      var result = await _datasource.confirm(userShopId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultNotificationModel>> reject(
      int userShopId) async {
    try {
      var result = await _datasource.reject(userShopId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
