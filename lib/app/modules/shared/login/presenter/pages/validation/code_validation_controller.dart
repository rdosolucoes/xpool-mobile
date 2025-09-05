import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../domain/usecases/interfaces/send_remember_psw_email_interface.dart';
import '../../../domain/usecases/interfaces/validate_email_interface.dart';

class CodeValidationController {
  final IValidateEmail _validateEmail;
  final ISendRememberPswEmail _sendRememberPswEmail;
  final AuthStore _authStore;

  CodeValidationController(
      this._validateEmail, this._sendRememberPswEmail, this._authStore);

  Future<bool> validateEmail(String code) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);
    await Future.delayed(Duration(seconds: 1));

    var isValidate = false;
    var userName = _authStore.state.userName;
    var result = await _validateEmail(userName, code);

    overlay.remove();
    result.fold(
      (l) {
        isValidate = false;
      },
      (r) {
        isValidate = r;
      },
    );

    return isValidate;
  }

  Future<bool> resendEmail(String email) async {
    var overlay = OverlayEntry(
      builder: (context) {
        return LoadingProgressIndicatorWidget(
          isCustom: true,
        );
      },
    );
    asuka.addOverlay(overlay);
    await Future.delayed(Duration(seconds: 1));

    var isValidate = false;
    var userName = _authStore.state.userName;
    var result = await _sendRememberPswEmail(userName);

    overlay.remove();
    result.fold(
      (l) {
        isValidate = false;
      },
      (r) {
        isValidate = r;
      },
    );

    return isValidate;
  }

  Future<bool> sendEmail() async {
    var success = false;
    var userName = _authStore.state.userName;
    var result = await _sendRememberPswEmail(userName);

    result.fold(
      (l) {
        success = false;
      },
      (r) {
        success = r;
      },
    );

    return success;
  }
}
