import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/notificationSup_repository_interface.dart';
import 'interfaces/confirm_invite_shop_interface.dart';

class ConfirmInviteShop extends IConfirmInviteShop {
  final INotificationSupRepository _notificationRepository;

  ConfirmInviteShop(this._notificationRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int notificationId) {
    var result = _notificationRepository.confirm(notificationId);
    return result;
  }
}
