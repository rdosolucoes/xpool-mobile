import '../../models/shop_model.dart';

abstract class IShopDatasource {
  Future<ShopModel> postShop(ShopModel model);
}
