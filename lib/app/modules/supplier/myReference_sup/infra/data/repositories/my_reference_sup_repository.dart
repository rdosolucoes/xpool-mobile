import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../domain/entities/myreference_sup_entity.dart';
import '../../../domain/repositories/my_reference_sup_repository.dart';
import '../datasources/my_reference_sup_datasource_interface.dart';

class MyReferenceSupRepository implements IMyReferenceSupRepository {
  // final IShopDatasource _datasource;

  final IMyReferenceSupDatasource _datasource;

  MyReferenceSupRepository(this._datasource);

  @override
  Future<Either<Failure, List<MyReferenceSupEntity>>> get(
      int offset, int limit) async {
    try {
      var result = <MyReferenceSupEntity>[];
      var listShop = await _datasource.get(offset, limit);

      result = listShop
          .map((e) => MyReferenceSupEntity(
              id: e.id,
              shopLogo: e.shopLogo,
              shopName: e.shopName,
              customerName: e.customerName,
              needDescription: e.needDescription,
              customerPhone: e.customerPhone,
              dateHour: e.dateHour,
              taskDescription: e.taskDescription,
              iconNeed: e.iconNeed,
              localMainText: e.localMainText,
              localSecondaryText: e.localSecondaryText,
              latitude: e.latitude,
              longitude: e.longitude,
              status: e.status,
              doneDeal: e.doneDeal,
              reply: e.reply))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> setDoneDeal(
      int value, int referenceId) async {
    try {
      var result = await _datasource.setDoneDeal(value, referenceId);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
