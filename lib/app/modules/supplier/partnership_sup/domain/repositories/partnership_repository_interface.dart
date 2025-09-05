import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../../../../../../shared/models/result_notification_model.dart';

abstract class IPartnershipRepository {
  Future<Either<Failure, ResultNotificationModel>> post(int userShopId);
  Future<Either<Failure, ResultModel>> delete(int userShopId);
  Future<Either<Failure, ResultModel>> breakPartner(int userShopId);
}
