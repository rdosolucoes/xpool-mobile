import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../entities/notificationSup_entity.dart';

abstract class INotificationSupRepository {
  Future<Either<Failure, List<NotificationSupEntity>>> get();
  Future<Either<Failure, ResultNotificationModel>> confirm(int notificationId);
  Future<Either<Failure, ResultNotificationModel>> reject(int notificationId);
}
