import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../models/result_model.dart';

class NotificationDatasource {
  final DioForNative _client;

  NotificationDatasource(this._client);

  Future<int> getCountNotifications() async {
    final url = Api.countNotifications;

    final response = await _client.get(url);

    if (response.statusCode == 200 && response.data['success']) {
      var result = response.data['count'];

      return result;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        var msg = response.data['messageError'];
        throw DatasourceError(message: msg);
      }
    }
  }

  Future<ResultModel> updateNotifications() async {
    final url = Api.updateNotifications;

    final response = await _client.post(url);

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
