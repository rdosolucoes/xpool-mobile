import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/filter_partnershipShop_entity.dart';
import '../../../domain/entities/supplier_entity.dart';
import '../../../domain/repositories/supplier_repository_interface.dart';
import '../../models/filter_partnershipShop_model.dart';
import '../datasources/supplier_datasource_interface.dart';

class SupplierRepository implements ISupplierRepository {
  // final ISupplierDatasource _datasource;

  final ISupplierDatasource _datasource;

  SupplierRepository(this._datasource);

  @override
  Future<Either<Failure, List<SupplierEntity>>> get(
      FilterPartnershipShopEntity filter) async {
    try {
      var result = <SupplierEntity>[];

      var model = FilterPartnershipShopModel(
          filterneeds: filter.filterneeds,
          city: filter.city,
          showPartners: filter.showPartners);

      var listSupplier = await _datasource.get(model);

      result = listSupplier
          .map((e) => SupplierEntity(
              id: e.id,
              name: e.name,
              city: e.city,
              status: e.status,
              needs: e.needs,
              photo: e.photo))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
