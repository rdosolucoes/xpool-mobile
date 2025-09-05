import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/supplier_reference_entity.dart';

abstract class ISupplierReferenceRepository {
  Future<Either<Failure, List<SupplierReferenceEntity>>> getByNeed(int needId);
}
