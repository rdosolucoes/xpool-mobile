import 'package:dio/native_imp.dart';

import '../../../../../../../shared/auth/models/auth_model.dart';
import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/authenticate_datasource_interface.dart';
import '../../models/authenticate_model.dart';
import '../../models/change_psw_model.dart';

class AuthenticateDatasource implements IAuthenticateDatasource {
  final DioForNative _client;

  AuthenticateDatasource(this._client);

  Future<AuthModel> authenticate(AuthenticateModel auth) async {
    final url = auth.isSignUp ? Api.signUp : Api.signIn;

    final response = await _client.post(url, queryParameters: {
      "login": auth.login,
      "password": auth.password,
      "playerId": auth.playerId
    });

    if (response.statusCode == 200 && response.data['success']) {
      var model = AuthModel.fromHeader(response.headers);
      model = model.copyWith(
        userName: auth.login,
        password: auth.password,
      );
      return model;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        var msg = response.data['msg'];
        throw DatasourceError(message: msg);
      }
    }
  }

  @override
  Future<void> unauthenticate() async {
    final url = Api.signOut;

    final response = await _client.post(url);

    if (response.statusCode == 200 && response.data['success']) {
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        var msg = response.data['msg'];
        throw DatasourceError(message: msg);
      }
    }
  }

  @override
  Future<bool> validateEmail(String userName, String code) async {
    final url = Api.validateRememberPswEmail;

    final response = await _client.post(url, queryParameters: {
      "userName": userName,
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

  @override
  Future<bool> sendRememberPswEmail(String userName) async {
    final url = Api.sendRememberPswEmail;

    final response =
        await _client.post(url, queryParameters: {"userName": userName});

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

  @override
  Future<String> rememberPassword(String userName) async {
    final url = Api.rememberPassword;

    final response = await _client.get(url, queryParameters: {
      "userName": userName,
    });

    if (response.statusCode == 200 && response.data['success']) {
      var email = response.data['email'];
      return email;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        return "";
      }
    }
  }

  @override
  Future<ChangePswModel> changePassword(
      String userName, String newPassword) async {
    final url = Api.changePassword;

    final response = await _client.post(url, queryParameters: {
      "userName": userName,
      "newPassword": newPassword,
    });

    if (response.statusCode == 200 && response.data['success']) {
      var model = ChangePswModel.fromMap(response.data);
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
  Future<bool> cancelAccount() async {
    final url = Api.cancelAccount;

    final response = await _client.post(url);

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
