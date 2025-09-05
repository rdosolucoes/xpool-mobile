import '../../../../../../../shared/models/result_notification_model.dart';
import '../../models/notificationShop_model.dart';

abstract class INotificationShopDatasource {
  Future<List<NotificationShopModel>> get();

  Future<ResultNotificationModel> confirm(int userShopId);

  Future<ResultNotificationModel> reject(int userShopId);
}
