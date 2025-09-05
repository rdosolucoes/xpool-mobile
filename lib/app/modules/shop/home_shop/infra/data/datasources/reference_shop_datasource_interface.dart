import '../../../../../../../shared/models/result_model.dart';
import '../../../../partnership_shop/infra/models/supplier_model.dart';
import '../../models/reference_shop_model.dart';

abstract class IReferenceShopDataSource {
  Future<List<ReferenceShopModel>> get(int status);

  Future<List<SupplierModel>> getSuppliersByReference(int referenceId);
  Future<ResultModel> delete(int referenceId);
}
