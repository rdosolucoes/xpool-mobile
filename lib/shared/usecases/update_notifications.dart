import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/repository/notification_repository.dart';
import '../models/result_model.dart';

class UpdateNotifications {
  final NotificationRepository _notificationRepository;

  UpdateNotifications(this._notificationRepository);

  Future<Either<Failure, ResultModel>> call() async {
    var result = await _notificationRepository.updateNotifications();

    return result;
  }
}
