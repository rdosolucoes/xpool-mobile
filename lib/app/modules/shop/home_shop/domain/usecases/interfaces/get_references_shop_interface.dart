import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/reference_shop_entity.dart';

abstract class IGetReferencesShop {
  Future<Either<Failure, List<ReferenceShopEntity>>> call(int status);
}
