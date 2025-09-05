import '../../models/sup_model.dart';

abstract class ISupDatasource {
  Future<SupModel> postSup(SupModel model);
  Future<bool> sendCodeVerify(String email, String name, String phone);
}
