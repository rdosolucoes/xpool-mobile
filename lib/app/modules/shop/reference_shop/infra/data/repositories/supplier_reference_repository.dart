import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/supplier_reference_entity.dart';
import '../../../domain/repositories/supplier_reference_repository_interface.dart';
import '../datasources/supplier_reference_datasource_interface.dart';

class SupplierReferenceRepository implements ISupplierReferenceRepository {
  // final ISupplierReferenceDatasource _datasource;

  final ISupplierReferenceDatasource _datasource;

  SupplierReferenceRepository(this._datasource);

  @override
  Future<Either<Failure, List<SupplierReferenceEntity>>> getByNeed(
      int needId) async {
    try {
      var result = <SupplierReferenceEntity>[];
      var listSupplierReference = await _datasource.getByNeed(needId);

      result = listSupplierReference
          .map((e) => SupplierReferenceEntity(
              id: e.id,
              name: e.name,
              city: e.city,
              status: e.status,
              photo: e.photo,
              totalAccept: e.totalAccept,
              totalReference: e.totalAccept,
              totalReject: e.totalReject,
              recipientId: e.recipientId))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
