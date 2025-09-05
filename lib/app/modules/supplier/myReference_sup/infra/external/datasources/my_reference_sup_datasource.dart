import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../data/datasources/my_reference_sup_datasource_interface.dart';
import '../../models/my_reference_sup_model.dart';

class MyReferenceSupDataSource implements IMyReferenceSupDatasource {
  final DioForNative _client;

  MyReferenceSupDataSource(this._client);

  @override
  Future<List<MyReferenceSupModel>> get(int offset, int limit) async {
    final url = Api.myReferencesSup;

    final response = await _client
        .get(url, queryParameters: {"offset": offset, "limit": limit});
    var listShop = <MyReferenceSupModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("references") &&
          response.data["references"].isNotEmpty) {
        listShop = (response.data["references"] as List)
            .map((e) => MyReferenceSupModel.fromMap(e))
            .toList();
      }

      return listShop;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultModel> setDoneDeal(int value, int referenceId) async {
    final url = Api.setDoneDeal;

    final response = await _client.post(url,
        queryParameters: {"value": value, "referenceId": referenceId});

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
