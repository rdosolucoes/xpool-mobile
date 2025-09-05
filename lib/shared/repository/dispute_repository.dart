import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../app/modules/supplier/myReference_sup/infra/models/dispute_sup_model.dart';
import '../datasource/dispute_datasource.dart';
import '../models/result_notification_model.dart';

class DisputeRepository {
  // final INotificationShopDatasource _datasource;

  final DisputeDatasource _datasource;

  DisputeRepository(this._datasource);

  Future<Either<Failure, ResultNotificationModel>> create(
      DisputeModel model) async {
    try {
      var result = await _datasource.createDispute(model);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
