import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/partnership_repository_interface.dart';
import 'interfaces/cancel_invite_shop_interface.dart';

class CancelInviteShop implements ICancelInviteShop {
  final IPartnershipRepository _partnershipRepository;

  CancelInviteShop(this._partnershipRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int userShopId) {
    var result = _partnershipRepository.delete(userShopId);

    return result;
  }
}
