import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../entities/dispute_entity.dart';

abstract class IDisputeRepository {
  Future<Either<Failure, DisputeEntity>> get(int supId, int referenceId);
  Future<Either<Failure, ResultNotificationModel>> approve(int disputeId);
  Future<Either<Failure, ResultNotificationModel>> disapprove(
      int disputeId, String message);
}
