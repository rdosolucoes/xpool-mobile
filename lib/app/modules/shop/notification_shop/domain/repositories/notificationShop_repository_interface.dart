import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../entities/notificationShop_entity.dart';

abstract class INotificationShopRepository {
  Future<Either<Failure, List<NotificationShopEntity>>> get();
  Future<Either<Failure, ResultNotificationModel>> confirm(int notificationId);
  Future<Either<Failure, ResultNotificationModel>> reject(int notificationId);
}
