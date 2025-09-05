import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/notificationSup_entity.dart';
import '../repositories/notificationSup_repository_interface.dart';
import 'interfaces/get_sup_notifications_interface.dart';

class GetSupNotifications implements IGetSupNotifications {
  final INotificationSupRepository _notificationSupRepository;

  GetSupNotifications(this._notificationSupRepository);
  @override
  Future<Either<Failure, List<NotificationSupEntity>>> call() async {
    var result = await _notificationSupRepository.get();

    return result;
  }
}
