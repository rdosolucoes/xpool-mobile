import '../../../domain/entities/filter_partnershipSup_entity.dart';
import '../../models/shop_model.dart';

abstract class IShopDatasource {
  Future<List<ShopModel>> get(FilterPartnershipSupEntity filter);
}
