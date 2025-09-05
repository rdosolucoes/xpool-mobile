import 'package:dio/native_imp.dart';

import '../../../../helpers/api.dart';
import '../../../../helpers/errors.dart';
import '../../data/datasource/need_datasource_interface.dart';
import '../../model/need_model.dart';

class NeedDataSource implements INeedDatasource {
  final DioForNative _client;

  NeedDataSource(this._client);

  @override
  Future<List<NeedModel>> get() async {
    final url = Api.loadNeeds;

    final response = await _client.get(url);
    var listNeeds = <NeedModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("needs") &&
          response.data["needs"].isNotEmpty) {
        listNeeds = (response.data["needs"] as List)
            .map((e) => NeedModel.fromMap(e))
            .toList();
      }

      return listNeeds;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
