import '../../../../../../../shared/models/result_model.dart';
import '../../models/my_reference_sup_model.dart';

abstract class IMyReferenceSupDatasource {
  Future<List<MyReferenceSupModel>> get(int offset, int limit);

  Future<ResultModel> setDoneDeal(int value, int referenceId);
}
