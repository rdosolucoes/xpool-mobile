import '../../../../../../../shared/models/result_notification_model.dart';
import '../../models/dispute_model.dart';

abstract class IDisputeDataSource {
  Future<DisputeModel> get(int supId, int referenceId);
  Future<ResultNotificationModel> approve(int disputeId);
  Future<ResultNotificationModel> disapprove(int disputeId, String message);
}
