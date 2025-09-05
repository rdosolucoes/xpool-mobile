import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../infra/models/shop_model.dart';
import '../../entities/shop_entity.dart';

abstract class IPostShop {
  Future<Either<Failure, ShopModel>> call(ShopEntity request);
}
