import '../../models/partner_shop_model.dart';

abstract class IPartnerShopDataSource {
  Future<List<PartnerShopModel>> get();
}
