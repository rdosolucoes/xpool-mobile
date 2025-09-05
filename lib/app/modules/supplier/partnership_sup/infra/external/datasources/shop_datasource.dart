import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/filter_partnershipSup_entity.dart';
import '../../data/datasources/shop_datasource_interface.dart';
import '../../models/shop_model.dart';

class ShopDataSource implements IShopDatasource {
  final DioForNative _client;

  ShopDataSource(this._client);

  @override
  Future<List<ShopModel>> get(FilterPartnershipSupEntity filter) async {
    final url = Api.searchShops;
    var cityId = 0;

    if (filter.city != null) cityId = filter.city!.id;

    var showPartners = filter.showPartners;

    final response = await _client.get(url,
        queryParameters: {"cityId": cityId, "showPartners": showPartners});
    var listShop = <ShopModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("shops") &&
          response.data["shops"].isNotEmpty) {
        listShop = (response.data["shops"] as List)
            .map((e) => ShopModel.fromMap(e))
            .toList();
      }

      return listShop;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
