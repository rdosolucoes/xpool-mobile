import '../../../../../../../shared/models/result_model.dart';
import '../../../../../../../shared/models/result_notification_model.dart';

abstract class IPartnershipDatasource {
  Future<ResultNotificationModel> post(int userShopId);
  Future<ResultModel> delete(int userShopId);
  Future<ResultModel> breakPartner(int userShopId);
}
