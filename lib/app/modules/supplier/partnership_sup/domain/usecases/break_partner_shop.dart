import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/partnership_repository_interface.dart';
import 'interfaces/break_partner_shop_interface.dart';

class BreakPartnerShop implements IBreakPartnerShop {
  final IPartnershipRepository _partnershipRepository;

  BreakPartnerShop(this._partnershipRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int userShopId) {
    var result = _partnershipRepository.breakPartner(userShopId);

    return result;
  }
}
