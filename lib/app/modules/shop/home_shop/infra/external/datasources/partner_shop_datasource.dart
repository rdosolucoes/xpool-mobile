import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/partner_shop_datasource_interface.dart';
import '../../models/partner_shop_model.dart';

class PartnerShopDataSource implements IPartnerShopDataSource {
  final DioForNative _client;

  PartnerShopDataSource(this._client);

  @override
  Future<List<PartnerShopModel>> get() async {
    final url = Api.searchPartnersShop;

    final response = await _client.get(url);
    var listPartnerShop = <PartnerShopModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("partners") &&
          response.data["partners"].isNotEmpty) {
        listPartnerShop = (response.data["partners"] as List)
            .map((e) => PartnerShopModel.fromMap(e))
            .toList();
      }

      return listPartnerShop;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
