import 'package:dio/native_imp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../app/modules/supplier/myReference_sup/infra/models/dispute_sup_model.dart';
import '../models/result_notification_model.dart';

class DisputeDatasource {
  final DioForNative _client;

  DisputeDatasource(this._client);

  Future<ResultNotificationModel> createDispute(DisputeModel model) async {
    final url = Api.createDispute;

    final response = await _client.post(url, data: model.toJson());

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
