import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../../domain/entities/reference_entity.dart';
import '../../../domain/repositories/reference_repository_interface.dart';
import '../../models/reference_model.dart';
import '../datasources/reference_datasource_interface.dart';

class ReferenceRepository implements IReferenceRepository {
  // final IReferenceDatasource _datasource;

  final IReferenceDatasource _datasource;

  ReferenceRepository(this._datasource);

  @override
  Future<Either<Failure, ResultNotificationModel>> create(
      ReferenceEntity request) async {
    try {
      var model = ReferenceModel(
          name: request.name,
          mainText: request.localization!.mainText,
          secondaryText: request.localization!.secondaryText,
          latitude: request.localization!.latitude,
          longitude: request.localization!.longitude,
          description: request.description,
          phone: request.phone,
          needId: request.needId,
          supIds: request.supIds);

      var result = await _datasource.create(model);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
