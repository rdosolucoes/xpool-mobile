import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/supplier_reference_datasource_interface.dart';
import '../../models/supplier_reference_model.dart';

class SupplierReferenceDataSource implements ISupplierReferenceDatasource {
  final DioForNative _client;

  SupplierReferenceDataSource(this._client);

  @override
  Future<List<SupplierReferenceModel>> getByNeed(int needId) async {
    final url = Api.searchSuppliersByNeed;

    final response =
        await _client.get(url, queryParameters: {"needId": needId});
    var listSupplier = <SupplierReferenceModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("suppliers") &&
          response.data["suppliers"].isNotEmpty) {
        listSupplier = (response.data["suppliers"] as List)
            .map((e) => SupplierReferenceModel.fromMap(e))
            .toList();
      }

      return listSupplier;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
