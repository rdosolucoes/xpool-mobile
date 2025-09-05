import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/consts.dart';
import '../../../../../../../shared/helpers/encryptData.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../data/datasources/creditCard_interface.dart';
import '../../models/creditCard_model.dart';
import '../../models/creditCard_response_model.dart';
import '../../models/creditCard_token_model.dart';
import '../../models/token_model.dart';

class CreditCardDataSource extends ICreditCardDataSource {
  final DioForNative _client;

  CreditCardDataSource(this._client);

  @override
  Future<CreditCardModel> get() async {
    final url = Api.getCreditCards;

    final response = await _client.get(url);

    if (response.statusCode == 200 && response.data['success']) {
      var model = CreditCardModel.fromMap(response.data['bankAccount']);
      return model;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultModel> post(CreditCardModel model) async {
    var tokenModel = TokenModel(
        type: 'card',
        card: CreditCardTokenModel(
            number: EncryptData.decryptAES(model.number).replaceAll(' ', ''),
            holderName: EncryptData.decryptAES(model.holderName),
            cvv: EncryptData.decryptAES(model.cvv),
            label: model.brand,
            expMonth:
                EncryptData.decryptAES(model.validateDate).substring(0, 2),
            expYear:
                EncryptData.decryptAES(model.validateDate).substring(3, 5)));

    var token = await createToken(tokenModel);

    final url = Api.saveCreditCard;

    final response = await _client.post(url, queryParameters: {"token": token});

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

  @override
  Future<List<CreditCardResponseModel>> getAll() async {
    final url = Api.getCreditCards;

    final response = await _client.get(url);
    var listCards = <CreditCardResponseModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("creditCards") &&
          response.data["creditCards"].isNotEmpty) {
        listCards = (response.data["creditCards"] as List)
            .map((e) => CreditCardResponseModel.fromMap(e))
            .toList();
      }

      return listCards;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  Future<String> createToken(TokenModel model) async {
    final url = Api.generateToken;
    final dio = Dio();

    dio.options.baseUrl = "https://api.pagar.me/core/v5/";
    try {
      final response = await dio.post(url,
          data: model.toJson(), queryParameters: {"appId": pkPagarme});

      if (response.statusCode == 200) {
        var model = TokenModel.fromMap(response.data);
        return model.token ?? "";
      } else {
        if (response.statusCode != 200) {
          throw DatasourceError(
              message: "Sistema temporariamente indisponível.");
        } else {
          var msg = response.data['messageError'];
          throw DatasourceError(message: msg);
        }
      }
    } on Exception {
      throw DatasourceError(message: "Dados de cartão inválidos");
    }
  }

  @override
  Future<ResultModel> delete(String cardId) async {
    final url = Api.deleteCreditCard;

    final response =
        await _client.post(url, queryParameters: {"creditCardId": cardId});

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

  @override
  Future<ResultModel> setDefault(String cardId) async {
    final url = Api.setDefaultCreditCard;

    final response =
        await _client.post(url, queryParameters: {"creditCardId": cardId});

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
