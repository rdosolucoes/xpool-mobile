import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../../../partnership_shop/domain/entities/supplier_entity.dart';
import '../entities/reference_shop_entity.dart';

abstract class IReferenceShopRepository {
  Future<Either<Failure, List<ReferenceShopEntity>>> get(int status);

  Future<Either<Failure, List<SupplierEntity>>> getSuppliersByReference(
      int referenceId);

  Future<Either<Failure, ResultModel>> delete(int idReference);
}
