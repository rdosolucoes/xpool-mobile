import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/reference_shop_entity.dart';
import '../repositories/reference_shop_repository_interface.dart';
import 'interfaces/get_references_shop_interface.dart';

class GetReferencesShop implements IGetReferencesShop {
  final IReferenceShopRepository _referenceRepository;

  GetReferencesShop(this._referenceRepository);
  @override
  Future<Either<Failure, List<ReferenceShopEntity>>> call(int status) async {
    var result = await _referenceRepository.get(status);

    return result;
  }
}
