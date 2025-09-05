import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../data/datasources/bank_account_datasource_interface.dart';
import '../../models/bank_account_model.dart';

class BankAccountDataSource extends IBankAccountDataSource {
  final DioForNative _client;

  BankAccountDataSource(this._client);

  @override
  Future<BankAccountModel> get() async {
    final url = Api.getBankAccount;

    final response = await _client.get(url);

    if (response.statusCode == 200 && response.data['success']) {
      var model = BankAccountModel.fromMap(response.data['bankAccount']);
      return model;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultModel> post(BankAccountModel model) async {
    final url = Api.saveBankAccount;

    final response = await _client.post(url, data: model.toJson());

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
