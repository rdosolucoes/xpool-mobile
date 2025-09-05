import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/filter_partnershipSup_entity.dart';
import '../entities/shop_entity.dart';
import '../repositories/shop_repository_interface.dart';
import 'interfaces/get_all_shops_interface.dart';

class GetAllShops implements IGetAllShops {
  final IShopRepository _supplierRepository;

  GetAllShops(this._supplierRepository);
  @override
  Future<Either<Failure, List<ShopEntity>>> call(
      FilterPartnershipSupEntity filter) async {
    var result = await _supplierRepository.get(filter);

    return result;
  }
}
