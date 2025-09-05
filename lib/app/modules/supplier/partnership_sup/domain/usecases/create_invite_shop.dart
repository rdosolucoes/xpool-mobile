import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/partnership_repository_interface.dart';
import 'interfaces/create_invite_shop_interface.dart';

class CreateInviteShop implements ICreateInviteShop {
  final IPartnershipRepository _partnershipRepository;

  CreateInviteShop(this._partnershipRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int userShopId) {
    var result = _partnershipRepository.post(userShopId);

    return result;
  }
}
