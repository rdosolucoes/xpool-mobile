import 'package:dio/native_imp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../../shared/helpers/api.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../data/datasources/dispute_datasource_interface.dart';
import '../models/dispute_model.dart';

class DisputeDataSource implements IDisputeDataSource {
  final DioForNative _client;

  DisputeDataSource(this._client);

  @override
  Future<DisputeModel> get(int supId, int referenceId) async {
    final url = Api.getDispute;

    final response = await _client.get(url,
        queryParameters: {"supId": supId, "referenceId": referenceId});

    if (response.statusCode == 200 && response.data['success']) {
      var model = DisputeModel.fromMap(response.data['dispute']);
      return model;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultNotificationModel> approve(int disputeId) async {
    final url = Api.approveDispute;

    final response =
        await _client.post(url, queryParameters: {"disputeId": disputeId});

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
  Future<ResultNotificationModel> disapprove(
      int disputeId, String message) async {
    final url = Api.disapproveDispute;

    final response = await _client
        .post(url, queryParameters: {"disputeId": disputeId, "reply": message});

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
}
