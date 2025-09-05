import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../shared/auth/local_storage/interfaces/auth_repository_interface.dart';
import '../../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../../shared/components/loading_progress_indicator/loading_progress_indicator_widget.dart';
import '../../../../../../../shared/helpers/enum.dart';
import '../../../domain/entities/sup_entity.dart';
import '../../../domain/usecases/interfaces/get_needs_interface.dart';
import '../../../domain/usecases/interfaces/post_sup_interface.dart';
import '../../../domain/usecases/interfaces/send_code_verify.dart';
import '../../stores/need_store.dart';
import '../../stores/registerSup_store.dart';

class SelectNeedsSupController {
  final SupEntity model;
  final NeedStore store;
  final RegisterSupStore supStore;
  final IGetNeeds _getNeeds;
  final IPostSup _postSup;
  final AuthStore _authStore;
  final IAuthLocalStorage _localStorage;
  final ISendCodeVerify _sendCodeVerify;

  SelectNeedsSupController(
      this.model,
      this.store,
      this._getNeeds,
      this._postSup,
      this._authStore,
      this._localStorage,
      this.supStore,
      this._sendCodeVerify);

  Future<void> getNeeds() async {
    if (store.state.needs.isEmpty) {
      store.setNeeds(_getNeeds());
    }
  }

  Future<void> confirm() async {
    if (store.state.addedNeeds.isEmpty) {
      asuka.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Selecione pelo menos um serviço"),
      ));
      return;
    }

    model.needsId = store.state.addedNeeds;

    var isEmailValidate = _authStore.isEmailValidate() ?? false;

    if (isEmailValidate) {
      await createUserSup(model);
    } else {
      _sendCodeVerify(model.email, model.name, model.phone);
      Modular.to.pushNamed('/registerSup/codeValidationSup', arguments: model);
    }
  }

  Future<void> createUserSup(SupEntity model) async {
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
      var result = await _postSup(model);

      result.fold((l) {
        var msgError = "Falha ao salvar o Fornecedor.";

        if (l.message != null) {
          msgError = l.message!;
        }

        asuka.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(msgError),
        ));
      }, (r) {
        _authStore.setTypeUser(ETypeUser.supplier.index);
        _authStore.setName(model.name);
        _authStore.setEmailValidate(true);
        _localStorage.update(_authStore.state);
        Modular.to.navigate('/startSup/homeSup');
      });
    } finally {
      overlay.remove();
    }
  }
}
