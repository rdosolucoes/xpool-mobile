import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/filter_partnershipSup_entity.dart';
import '../entities/shop_entity.dart';

abstract class IShopRepository {
  Future<Either<Failure, List<ShopEntity>>> get(
      FilterPartnershipSupEntity filter);
}
