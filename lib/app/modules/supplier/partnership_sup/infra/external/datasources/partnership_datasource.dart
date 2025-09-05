import 'package:dio/native_imp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../data/datasources/partnership_datasource.interface.dart';

class PartnershipDataSource implements IPartnershipDatasource {
  final DioForNative _client;

  PartnershipDataSource(this._client);

  @override
  Future<ResultNotificationModel> post(int userShopId) async {
    final url = Api.createInviteToShop;

    final response =
        await _client.post(url, queryParameters: {"userShopId": userShopId});

    if (response.statusCode == 200 && response.data['success']) {
      var model = ResultNotificationModel.fromMap(response.data);

      if (model.playerIds != null && model.playerIds!.isNotEmpty) {
        OneSignal.shared.postNotification(OSCreateNotification(
            playerIds: model.playerIds!, content: model.content));
      }
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
  Future<ResultModel> delete(int userShopId) async {
    final url = Api.cancelInviteToShop;

    final response =
        await _client.post(url, queryParameters: {"userShopId": userShopId});

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
  Future<ResultModel> breakPartner(int userShopId) async {
    final url = Api.breakPartnerSup;

    final response =
        await _client.post(url, queryParameters: {"userShopId": userShopId});

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
