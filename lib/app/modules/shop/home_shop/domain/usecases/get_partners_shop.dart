import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/partner_shop_entity.dart';
import '../repositories/partner_shop_repository_interface.dart';
import 'interfaces/get_partners_shop_interface.dart';

class GetPartnersShop implements IGetPartnersShop {
  final IPartnerShopRepository _partnerRepository;

  GetPartnersShop(this._partnerRepository);
  @override
  Future<Either<Failure, List<PartnerShopEntity>>> call() async {
    var result = await _partnerRepository.get();

    return result;
  }
}
