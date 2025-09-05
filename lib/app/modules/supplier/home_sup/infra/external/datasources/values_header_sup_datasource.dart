import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/values_header_sup_datasource_interface.dart';
import '../../models/values_header_sup_model.dart';

class ValuesHeaderSupDataSource implements IValuesHeaderSupDataSource {
  final DioForNative _client;

  ValuesHeaderSupDataSource(this._client);

  @override
  Future<ValuesHeaderSupModel> get() async {
    final url = Api.getValuesHeaderSup;

    final response = await _client.get(url);

    if (response.statusCode == 200 && response.data['success']) {
      var model = ValuesHeaderSupModel.fromMap(response.data['values']);
      return model;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
