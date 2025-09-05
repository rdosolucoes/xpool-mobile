import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/shop_datasource_interface.dart';
import '../../models/shop_model.dart';

class ShopDataSource implements IShopDatasource {
  final DioForNative _client;

  ShopDataSource(this._client);

  @override
  Future<ShopModel> postShop(ShopModel model) async {
    final url = Api.createShop;

    final response = await _client.post(url, data: model.toJson());

    if (response.statusCode == 200 && response.data['success']) {
      var model = ShopModel.fromMap(response.data);
      return model;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        var msg = response.data['messageError'];
        throw DatasourceError(message: msg);
      }
    }
  }
}
