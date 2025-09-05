import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/profile_shop_model.dart';
import '../entities/profile_shop_entity.dart';

abstract class IProfileShopRepository {
  Future<Either<Failure, ProfileShopEntity>> get();
  Future<Either<Failure, ProfileShopModel>> postProfile(
      ProfileShopEntity request);
}
