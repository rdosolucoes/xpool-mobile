import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../../partnership_shop/infra/models/supplier_model.dart';
import '../../data/datasources/reference_shop_datasource_interface.dart';
import '../../models/reference_shop_model.dart';

class ReferenceShopDataSource implements IReferenceShopDataSource {
  final DioForNative _client;

  ReferenceShopDataSource(this._client);

  @override
  Future<List<ReferenceShopModel>> get(status) async {
    final url = Api.loadReferences;

    final response =
        await _client.get(url, queryParameters: {"status": status});
    var listReferenceShop = <ReferenceShopModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("references") &&
          response.data["references"].isNotEmpty) {
        listReferenceShop = (response.data["references"] as List)
            .map((e) => ReferenceShopModel.fromMap(e))
            .toList();
      }

      for (var element in listReferenceShop) {
        element.suppliers = await getSuppliersByReference(element.id);
      }
      return listReferenceShop;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<List<SupplierModel>> getSuppliersByReference(int referenceId) async {
    final url = Api.supByReference;

    final response =
        await _client.get(url, queryParameters: {"referenceId": referenceId});
    var listReferenceShop = <SupplierModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("suppliers") &&
          response.data["suppliers"].isNotEmpty) {
        listReferenceShop = (response.data["suppliers"] as List)
            .map((e) => SupplierModel.fromMap(e))
            .toList();
      }

      return listReferenceShop;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultModel> delete(int referenceId) async {
    final url = Api.deleteReference;

    final response =
        await _client.post(url, queryParameters: {"referenceId": referenceId});
    if (response.statusCode == 200 && response.data['success']) {
      var model = ResultModel.fromMap(response.data);

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
