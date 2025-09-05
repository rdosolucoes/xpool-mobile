import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/filter_partnershipShop_entity.dart';
import '../entities/supplier_entity.dart';

abstract class ISupplierRepository {
  Future<Either<Failure, List<SupplierEntity>>> get(
      FilterPartnershipShopEntity filter);
}
