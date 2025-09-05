import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/sup_datasource_interface.dart';
import '../../models/sup_model.dart';

class SupDataSource implements ISupDatasource {
  final DioForNative _client;

  SupDataSource(this._client);

  @override
  Future<SupModel> postSup(SupModel model) async {
    final url = Api.createSupplier;

    final response = await _client.post(url, data: model.toJson());

    if (response.statusCode == 200 && response.data['success']) {
      var model = SupModel.fromMap(response.data);
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

  @override
  Future<bool> sendCodeVerify(String email, String name, String phone) async {
    final url = Api.sendCodeVerify;

    final response = await _client.post(url,
        queryParameters: {"toEmail": email, "name": name, "phone": phone});

    if (response.statusCode == 200 && response.data['success']) {
      return true;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        return false;
      }
    }
  }
}
