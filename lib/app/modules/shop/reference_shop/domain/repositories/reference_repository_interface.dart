import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../entities/reference_entity.dart';

abstract class IReferenceRepository {
  Future<Either<Failure, ResultNotificationModel>> create(
      ReferenceEntity request);
}
