import '../../../../../../../shared/models/result_notification_model.dart';
import '../../models/reference_model.dart';

abstract class IReferenceDatasource {
  Future<ResultNotificationModel> create(ReferenceModel model);
}
