import 'package:asuka/asuka.dart' as asuka;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../../shared/helpers/enum.dart';
import '../../../domain/entities/authenticate_entity.dart';
import '../../../domain/usecases/interfaces/post_authenticate_by_login_interface.dart';
import '../../../domain/usecases/interfaces/remember_password_interface.dart';
import '../../../domain/usecases/interfaces/send_remember_psw_email_interface.dart';

class LoginController {
  final IPostAuthenticateByLogin _authenticateByLogin;
  final ISendRememberPswEmail sendRememberPswEmail;
  final IRememberPassword _rememberPassword;
  final AuthStore store;

  LoginController(this._authenticateByLogin, this.store,
      this.sendRememberPswEmail, this._rememberPassword);

  void setError(String v) => store.setErrorMsg(v);
  void setUserName(String v) => store.setUserName(v);
  void setPassword(String v) => store.setPassword(v);
  void setConfirmPassword(String v) => store.setConfirmPassword(v);
  void setSignMode(v) => store.setSignMode(v);
  void setTypeUser(v) => store.setTypeUser(v);
  void setName(v) => store.setName(v);

  Future<void> login(String login, String password, String confirmPassword,
      String? errorMsg) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);
    await Future.delayed(Duration(seconds: 2));

    var isSignUp = store.state.isSignMode == true;
    var playerId = store.state.playerId;
    var emailValidate = store.state.emailValidate;

    var requestAuthenticate = AuthenticateEntity(
        login: login,
        password: password,
        confirmPassword: confirmPassword,
        isSignUp: isSignUp,
        typeUser: 0,
        name: "",
        playerId: playerId ?? "",
        emailValidate: emailValidate ?? false);

    var request = requestAuthenticate;
    var result = await _authenticateByLogin(request);

    await store.setLogin(result);
    print(store.state);
    overlay.remove();
    if (result is Right) {
      if (isSignUp || store.getTypeUser() == ETypeUser.undefined) {
        Modular.to.navigate('/typeUser');
      } else {
        if (store.getTypeUser() == ETypeUser.shop) {
          Modular.to.navigate('/startShop/homeShop');
        } else {
          Modular.to.navigate('/startSup/homeSup');
        }
      }
    }
  }

  void switchAuthMode() {
    if (store.state.isSignMode == false) {
      store.setSignMode(true);
    } else {
      store.setSignMode(false);
    }
  }

  Future<String> rememberPassword() async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);
    await Future.delayed(Duration(seconds: 2));

    try {
      var userName = store.state.userName;

      if (userName.isEmpty) return "";

      var resultFuture = await _rememberPassword(userName);
      var result = "";

      resultFuture.fold((l) => result = "", (r) {
        if (r != "") {
          result = r;
        }
      });

      return result;
    } finally {
      overlay.remove();
    }
  }

  void clearStore() {
    if (!store.state.userName.isEmpty) store.clear();
  }
}
