import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../datasource/notification_datasource.dart';
import '../models/result_model.dart';

class NotificationRepository {
  // final INotificationShopDatasource _datasource;

  final NotificationDatasource _datasource;

  NotificationRepository(this._datasource);

  Future<Either<Failure, int>> getCountNotifications() async {
    try {
      var result = await _datasource.getCountNotifications();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, ResultModel>> updateNotifications() async {
    try {
      var result = await _datasource.updateNotifications();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
