import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/notificationShop_repository_interface.dart';
import 'interfaces/confirm_invite_sup_interface.dart';

class ConfirmInviteSup extends IConfirmInviteSup {
  final INotificationShopRepository _notificationRepository;

  ConfirmInviteSup(this._notificationRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int notificationId) {
    var result = _notificationRepository.confirm(notificationId);
    return result;
  }
}
