import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../shared/login/domain/usecases/interfaces/cancel_account_interface.dart';
import '../../../../shared/login/domain/usecases/interfaces/log_out_interface.dart';

class MenuSupController {
  final ILogOut _logOut;
  final ICancelAccount _cancelAccount;
  final AuthStore authStore;
  String? name = "";
  String msgWelcome = "Bem Vindo Lojista";

  MenuSupController(this._logOut, this._cancelAccount, this.authStore);

  void getLogin() {
    name = authStore.state.name;

    if (authStore.state.typeUser != 1) {
      msgWelcome = "Bem Vindo Fornecedor";
    }
  }

  Future<void> logout() async {
    await _logOut();
    authStore.clear();
    Modular.to.navigate('/login');
  }

  Future<void> cancelAccount() async {
    authStore.setPendingDelete(true);
    await _cancelAccount();
  }

  bool isPendingDelete() {
    return authStore.state.pendingDelete ?? false;
  }
}
