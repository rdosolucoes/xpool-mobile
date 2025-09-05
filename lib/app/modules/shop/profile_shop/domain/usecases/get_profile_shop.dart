import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/profile_shop_entity.dart';
import '../repositories/profile_shop_repository_interface.dart';
import 'interface/get_profile_shop_interface.dart';

class GetProfileShop extends IGetProfileShop {
  final IProfileShopRepository _profileShopRepository;

  GetProfileShop(this._profileShopRepository);

  @override
  Future<Either<Failure, ProfileShopEntity>> call() async {
    var result = await _profileShopRepository.get();
    return result;
  }
}
