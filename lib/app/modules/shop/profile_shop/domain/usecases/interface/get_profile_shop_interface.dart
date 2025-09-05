import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/profile_shop_entity.dart';

abstract class IGetProfileShop {
  Future<Either<Failure, ProfileShopEntity>> call();
}
