import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import '../../../../../../shared/usecases/update_notifications.dart';

import '../../domain/usecases/interfaces/confirm_invite_shop_interface.dart';
import '../../domain/usecases/interfaces/get_sup_notifications_interface.dart';
import '../../domain/usecases/interfaces/reject_invite_shop_interface.dart';
import '../stores/notificationSup_store.dart';

class NotificationSupController {
  final IGetSupNotifications _getSupNotifications;
  final IConfirmInviteShop _confirmInviteShop;
  final IRejectInviteShop _rejectInviteShop;
  final NotificationSupStore store;
  final UpdateNotifications _updateNotifications;

  NotificationSupController(this._getSupNotifications, this._confirmInviteShop,
      this._rejectInviteShop, this.store, this._updateNotifications) {
    getNotifications();
  }

  Future<void> getNotifications() async {
    store.setNotifications(_getSupNotifications());
  }

  Future<void> updateNotifications() async {
    _updateNotifications.call();
  }

  Future<void> confirmInvite(int notificationId, int index) async {
    var result = await _confirmInviteShop.call(notificationId);

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
    var result = await _rejectInviteShop.call(notificationId);

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
