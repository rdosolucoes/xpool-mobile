import 'package:asuka/asuka.dart' as asuka;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../domain/entities/change_psw_entity.dart';
import '../../../domain/usecases/change_password.dart';
import '../../stores/change_psw_store.dart';

class ChangePswController {
  final ChangePswStore store;
  final ChangePassword _changePassword;
  final AuthStore _authStore;

  ChangePswController(this.store, this._changePassword, this._authStore);

  void setPassword(String v) => store.setPassword(v);
  void setConfirmPassword(String v) => store.setConfirmPassword(v);

  Future<void> changePassword(
      String password, String confirmPassword, String? errorMsg) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);
    await Future.delayed(Duration(seconds: 2));

    var changePswEntity = ChangePswEntity(
      userName: _authStore.state.userName,
      password: password,
      confirmPassword: confirmPassword,
    );

    var result = await _changePassword(changePswEntity);

    store.setChangePassword(result);

    print(store.state);
    overlay.remove();
    if (result is Right) {
      store.clear();
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Senha atualizada com Sucesso!"),
      ));
      Modular.to.popUntil(ModalRoute.withName("login"));
    }
  }
}
