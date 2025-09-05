import 'package:dio/native_imp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_notification_model.dart';
import '../../data/datasources/notificationSup_datasource_interface.dart';
import '../../models/notificationSup_model.dart';

class NotificationSupDataSource implements INotificationSupDatasource {
  final DioForNative _client;

  NotificationSupDataSource(this._client);

  @override
  Future<List<NotificationSupModel>> get() async {
    final url = Api.loadNotifications;

    final response = await _client.get(url);
    var listNotifications = <NotificationSupModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("notifications") &&
          response.data["notifications"].isNotEmpty) {
        listNotifications = (response.data["notifications"] as List)
            .map((e) => NotificationSupModel.fromMap(e))
            .toList();
      }

      return listNotifications;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ResultNotificationModel> confirm(int notificationId) async {
    final url = Api.confirmInviteFromShop;

    final response = await _client
        .post(url, queryParameters: {"notificationId": notificationId});

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
  Future<ResultNotificationModel> reject(int notificationId) async {
    final url = Api.rejectInviteFromShop;

    final response = await _client
        .post(url, queryParameters: {"notificationId": notificationId});

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
