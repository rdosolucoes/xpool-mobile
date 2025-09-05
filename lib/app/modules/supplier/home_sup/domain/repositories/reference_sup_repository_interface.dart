import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../entities/reference_sup_entity.dart';

abstract class IReferenceSupRepository {
  Future<Either<Failure, List<ReferenceSupEntity>>> get();
  Future<Either<Failure, ResultNotificationModel>> accept(int referenceId);
  Future<Either<Failure, ResultNotificationModel>> reject(int referenceId);
}
