import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/notificationShop_repository_interface.dart';
import 'interfaces/reject_invite_sup_interface.dart';

class RejectInviteSup extends IRejectInviteSup {
  final INotificationShopRepository _notificationRepository;

  RejectInviteSup(this._notificationRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int notificationId) {
    var result = _notificationRepository.reject(notificationId);
    return result;
  }
}
