import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/values_datasource_interface.dart';
import '../../models/values_model.dart';

class ValuesDataSource implements IValuesDataSource {
  final DioForNative _client;

  ValuesDataSource(this._client);

  @override
  Future<ValuesModel> get() async {
    final url = Api.getValuesHeaderShop;

    final response = await _client.get(url);

    if (response.statusCode == 200 && response.data['success']) {
      var model = ValuesModel.fromMap(response.data['values']);
      return model;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
