import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../domain/usecases/interfaces/send_code_verify.dart';
import '../../../domain/usecases/interfaces/validate_email_interface.dart';

class CodeValidationSupController {
  final IValidateEmail _validateEmail;
  final ISendCodeVerify _sendCodeVerify;

  CodeValidationSupController(this._validateEmail, this._sendCodeVerify);

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
    var result = await _validateEmail(code);

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

  Future<bool> resendEmail(String email, String code, String phone) async {
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
    var result = await _sendCodeVerify(email, code, phone);

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
}
