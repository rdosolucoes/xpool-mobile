import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/filter_partnershipShop_entity.dart';
import '../entities/supplier_entity.dart';
import '../repositories/supplier_repository_interface.dart';
import 'interfaces/get_all_suppliers_interface.dart';

class GetAllSuppliers implements IGetAllSuppliers {
  final ISupplierRepository _supplierRepository;

  GetAllSuppliers(this._supplierRepository);
  @override
  Future<Either<Failure, List<SupplierEntity>>> call(
      FilterPartnershipShopEntity filter) async {
    var result = await _supplierRepository.get(filter);

    return result;
  }
}
