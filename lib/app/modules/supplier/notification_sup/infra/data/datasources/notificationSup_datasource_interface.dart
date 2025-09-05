import '../../../../../../../shared/models/result_notification_model.dart';
import '../../models/notificationSup_model.dart';

abstract class INotificationSupDatasource {
  Future<List<NotificationSupModel>> get();

  Future<ResultNotificationModel> confirm(int userSupId);

  Future<ResultNotificationModel> reject(int userSupId);
}
