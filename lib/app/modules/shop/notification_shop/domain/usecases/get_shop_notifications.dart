import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/notificationShop_entity.dart';
import '../repositories/notificationShop_repository_interface.dart';
import 'interfaces/get_shop_notifications_interface.dart';

class GetShopNotifications implements IGetShopNotifications {
  final INotificationShopRepository _notificationShopRepository;

  GetShopNotifications(this._notificationShopRepository);
  @override
  Future<Either<Failure, List<NotificationShopEntity>>> call() async {
    var result = await _notificationShopRepository.get();

    return result;
  }
}
