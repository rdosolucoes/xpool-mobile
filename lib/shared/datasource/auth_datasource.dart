import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../models/result_model.dart';

class AuthDataSource {
  final DioForNative _client;

  AuthDataSource(this._client);

  Future<bool> validateEmail(String code) async {
    final url = Api.validateEmail;

    final response = await _client.post(url, queryParameters: {
      "code": code,
    });

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

  Future<ResultModel> validateForm(
      String name, String email, String phone) async {
    final url = Api.validateFormData;

    final response = await _client.get(url,
        queryParameters: {"name": name, "email": email, "phone": phone});

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
