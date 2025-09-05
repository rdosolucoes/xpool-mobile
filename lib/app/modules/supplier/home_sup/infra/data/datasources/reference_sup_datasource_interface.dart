import '../../../../../../../shared/models/result_notification_model.dart';
import '../../models/reference_sup_model.dart';

abstract class IReferenceSupDataSource {
  Future<List<ReferenceSupModel>> get();
  Future<ResultNotificationModel> accept(int referenceId);
  Future<ResultNotificationModel> reject(int referenceId);
}
