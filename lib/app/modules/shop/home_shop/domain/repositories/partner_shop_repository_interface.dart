import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/partner_shop_entity.dart';

abstract class IPartnerShopRepository {
  Future<Either<Failure, List<PartnerShopEntity>>> get();
}
