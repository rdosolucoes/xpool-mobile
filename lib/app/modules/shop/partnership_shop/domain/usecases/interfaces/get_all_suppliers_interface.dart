import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/filter_partnershipShop_entity.dart';
import '../../entities/supplier_entity.dart';

abstract class IGetAllSuppliers {
  Future<Either<Failure, List<SupplierEntity>>> call(
      FilterPartnershipShopEntity filter);
}
