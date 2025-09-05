import '../../models/filter_partnershipShop_model.dart';
import '../../models/supplier_model.dart';

abstract class ISupplierDatasource {
  Future<List<SupplierModel>> get(FilterPartnershipShopModel filter);
}
