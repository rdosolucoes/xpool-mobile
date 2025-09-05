import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/supplier_reference_entity.dart';

abstract class IGetReferenceSuppliers {
  Future<Either<Failure, List<SupplierReferenceEntity>>> call(int needId);
}
