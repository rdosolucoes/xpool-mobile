import '../../../../../../../shared/models/result_model.dart';
import '../../../../../../../shared/models/result_notification_model.dart';

abstract class IPartnershipDatasource {
  Future<ResultNotificationModel> post(int userSupId);
  Future<ResultModel> delete(int userSupId);
  Future<ResultModel> breakPartner(int userSupId);
}
