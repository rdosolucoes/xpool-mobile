import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/login/domain/repositories/authenticate_repository_interface.dart';
import '../../shared/login/domain/repositories/unauthenticate_repository_interface.dart';
import '../../shared/login/domain/usecases/cancel_account.dart';
import '../../shared/login/domain/usecases/interfaces/cancel_account_interface.dart';
import '../../shared/login/domain/usecases/interfaces/log_out_interface.dart';
import '../../shared/login/domain/usecases/log_out.dart';
import '../../shared/login/infra/data/datasources/authenticate_datasource_interface.dart';
import '../../shared/login/infra/data/repositories/authenticate_repository.dart';
import '../../shared/login/infra/data/repositories/unauthenticate_repository.dart';
import '../../shared/login/infra/external/datasources/authenticate_datasource.dart';
import 'presenter/pages/menuSup_controller.dart';
import 'presenter/pages/menuSup_page.dart';
import 'presenter/stores/menuSup_store.dart';

class MenuSupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MenuSupController(i(), i(), i())),
    Bind.lazySingleton<ILogOut>((i) => LogOut(i())),
    Bind.lazySingleton<ICancelAccount>((i) => CancelAccount(i())),
    Bind.lazySingleton<IUnauthenticateRepository>(
        (i) => UnauthenticateRepository(i(), i())),
    Bind.lazySingleton<IAuthenticateRepository>(
        (i) => AuthenticateRepository(i(), i())),
    Bind.lazySingleton<IAuthenticateDatasource>(
        (i) => AuthenticateDatasource(i())),
    Bind.lazySingleton((i) => MenuSupStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MenuSupPage()),
  ];
}
