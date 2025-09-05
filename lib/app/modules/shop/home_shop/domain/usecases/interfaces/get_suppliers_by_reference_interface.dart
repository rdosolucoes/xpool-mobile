import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../partnership_shop/domain/entities/supplier_entity.dart';

abstract class IGetSuppliersByReference {
  Future<Either<Failure, List<SupplierEntity>>> call(int referenceId);
}
