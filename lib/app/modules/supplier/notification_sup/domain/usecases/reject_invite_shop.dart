import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/notificationSup_repository_interface.dart';
import 'interfaces/reject_invite_shop_interface.dart';

class RejectInviteShop extends IRejectInviteShop {
  final INotificationSupRepository _notificationRepository;

  RejectInviteShop(this._notificationRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int notificationId) {
    var result = _notificationRepository.reject(notificationId);
    return result;
  }
}
