import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import '../../../../../../shared/usecases/update_notifications.dart';
import '../../domain/usecases/interfaces/confirm_invite_sup_interface.dart';
import '../../domain/usecases/interfaces/get_shop_notifications_interface.dart';
import '../../domain/usecases/interfaces/reject_invite_sup_interface.dart';
import '../stores/notificationShop_store.dart';

class NotificationShopController {
  final IGetShopNotifications _getShopNotifications;
  final IConfirmInviteSup _confirmInviteSup;
  final IRejectInviteSup _rejectInviteSup;
  final NotificationShopStore store;
  final UpdateNotifications _updateNotifications;

  NotificationShopController(this._getShopNotifications, this._confirmInviteSup,
      this._rejectInviteSup, this.store, this._updateNotifications) {
    getNotifications();
  }

  Future<void> getNotifications() async {
    store.setNotifications(_getShopNotifications());
  }

  Future<void> updateNotifications() async {
    _updateNotifications.call();
  }

  Future<void> confirmInvite(int notificationId, int index) async {
    var result = await _confirmInviteSup.call(notificationId);

    result.fold(
      (l) {
        var msgError = "Falha ao confirmar o convite.";

        if (l.message != null) {
          msgError = l.message!;
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(msgError),
        ));
        store.setStatus(index, 1);
      },
      (r) {},
    );
  }

  Future<void> rejectInvite(int notificationId, int index) async {
    var result = await _rejectInviteSup.call(notificationId);

    result.fold(
      (l) {
        var msgError = "Falha ao rejeitar o convite.";

        if (l.message != null) {
          msgError = l.message!;
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(msgError),
        ));
        store.setStatus(index, 2);
      },
      (r) {},
    );
  }
}
