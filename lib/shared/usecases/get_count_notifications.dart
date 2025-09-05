import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/repository/notification_repository.dart';

class GetCountNotifications {
  final NotificationRepository _notificationRepository;

  GetCountNotifications(this._notificationRepository);

  Future<Either<Failure, int>> call() async {
    var result = await _notificationRepository.getCountNotifications();

    return result;
  }
}
