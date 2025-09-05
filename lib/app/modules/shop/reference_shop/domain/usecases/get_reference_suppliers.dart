import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/supplier_reference_entity.dart';
import '../repositories/supplier_reference_repository_interface.dart';
import 'interfaces/get_reference_suppliers_interface.dart';

class GetReferenceSuppliers implements IGetReferenceSuppliers {
  final ISupplierReferenceRepository _supplierIndRepository;

  GetReferenceSuppliers(this._supplierIndRepository);
  @override
  Future<Either<Failure, List<SupplierReferenceEntity>>> call(
      int needId) async {
    var result = await _supplierIndRepository.getByNeed(needId);

    return result;
  }
}
