import 'package:dio/native_imp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../data/datasources/reference_sup_datasource_interface.dart';
import '../../models/reference_sup_model.dart';

class ReferenceSupDataSource implements IReferenceSupDataSource {
  final DioForNative _client;

  ReferenceSupDataSource(this._client);

  @override
  Future<List<ReferenceSupModel>> get() async {
    final url = Api.loadReferencesSup;

    final response = await _client.get(url);
    var listReferenceSup = <ReferenceSupModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("references") &&
          response.data["references"].isNotEmpty) {
        listReferenceSup = (response.data["references"] as List)
            .map((e) => ReferenceSupModel.fromMap(e))
            .toList();
      }

      return listReferenceSup;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultNotificationModel> accept(int referenceId) async {
    final url = Api.acceptReferenceSup;

    final response =
        await _client.post(url, queryParameters: {"referenceId": referenceId});

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
  Future<ResultNotificationModel> reject(int referenceId) async {
    final url = Api.rejectReferenceSup;

    final response =
        await _client.post(url, queryParameters: {"referenceId": referenceId});

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
