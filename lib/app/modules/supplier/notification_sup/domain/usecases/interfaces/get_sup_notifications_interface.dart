import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/notificationSup_entity.dart';

abstract class IGetSupNotifications {
  Future<Either<Failure, List<NotificationSupEntity>>> call();
}
