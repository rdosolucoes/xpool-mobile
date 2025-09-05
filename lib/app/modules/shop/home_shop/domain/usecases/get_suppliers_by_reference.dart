import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../partnership_shop/domain/entities/supplier_entity.dart';
import '../repositories/reference_shop_repository_interface.dart';
import 'interfaces/get_suppliers_by_reference_interface.dart';

class GetSuppliersByReference implements IGetSuppliersByReference {
  final IReferenceShopRepository _referenceRepository;

  GetSuppliersByReference(this._referenceRepository);
  @override
  Future<Either<Failure, List<SupplierEntity>>> call(int referenceId) async {
    var result =
        await _referenceRepository.getSuppliersByReference(referenceId);

    return result;
  }
}
