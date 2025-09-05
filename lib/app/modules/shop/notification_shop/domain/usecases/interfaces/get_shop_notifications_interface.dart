import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/notificationShop_entity.dart';

abstract class IGetShopNotifications {
  Future<Either<Failure, List<NotificationShopEntity>>> call();
}
