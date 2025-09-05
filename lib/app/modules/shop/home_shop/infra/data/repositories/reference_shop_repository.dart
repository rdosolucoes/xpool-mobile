import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../../partnership_shop/domain/entities/supplier_entity.dart';
import '../../../domain/entities/reference_shop_entity.dart';
import '../../../domain/repositories/reference_shop_repository_interface.dart';
import '../datasources/reference_shop_datasource_interface.dart';

class ReferenceShopRepository implements IReferenceShopRepository {
  final IReferenceShopDataSource _datasource;

  ReferenceShopRepository(this._datasource);

  @override
  Future<Either<Failure, List<ReferenceShopEntity>>> get(int status) async {
    try {
      var result = <ReferenceShopEntity>[];
      var listReferenceShop = await _datasource.get(status);

      result = listReferenceShop
          .map((e) => ReferenceShopEntity(
              id: e.id,
              dateHour: e.dateHour,
              need: e.need,
              customerName: e.customerName,
              iconNeed: e.iconNeed,
              localMainText: e.localMainText,
              localSecondaryText: e.localSecondaryText,
              latitude: e.latitude,
              longitude: e.longitude,
              totalAccept: e.totalAccept,
              totalReference: e.totalReference,
              totalReject: e.totalReject,
              totalContest: e.totalContest,
              status: e.status,
              suppliers: e.suppliers,
              employee: e.employee))
          .toList();

      if (result.isEmpty) {
        return Right<Failure, List<ReferenceShopEntity>>([]);
      }
      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> getSuppliersByReference(
      int referenceId) async {
    try {
      var result = <SupplierEntity>[];
      var listReferenceShop =
          await _datasource.getSuppliersByReference(referenceId);

      result = listReferenceShop
          .map((e) => SupplierEntity(name: e.name, status: e.status))
          .toList();

      if (result.isEmpty) {
        return Right<Failure, List<SupplierEntity>>([]);
      }
      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> delete(int idReference) async {
    try {
      var result = await _datasource.delete(idReference);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
