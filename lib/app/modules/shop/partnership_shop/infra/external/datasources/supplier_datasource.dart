import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/supplier_datasource_interface.dart';
import '../../models/filter_partnershipShop_model.dart';
import '../../models/supplier_model.dart';

class SupplierDataSource implements ISupplierDatasource {
  final DioForNative _client;

  SupplierDataSource(this._client);

  @override
  Future<List<SupplierModel>> get(FilterPartnershipShopModel filter) async {
    final url = Api.searchSuppliers;

    var needsId = '';
    var cityId = 0;

    if (filter.city != null) cityId = filter.city!.id;

    if (!filter.filterneeds.isEmpty) {
      needsId = filter.filterneeds.join(",");
    }

    var showPartners = filter.showPartners;

    final response = await _client.get(url, queryParameters: {
      "needsId": needsId,
      "cityId": cityId,
      "showPartners": showPartners
    });
    var listSupplier = <SupplierModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("suppliers") &&
          response.data["suppliers"].isNotEmpty) {
        listSupplier = (response.data["suppliers"] as List)
            .map((e) => SupplierModel.fromMap(e))
            .toList();
      }

      return listSupplier;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
