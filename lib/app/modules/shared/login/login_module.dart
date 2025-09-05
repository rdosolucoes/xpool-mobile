import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/authenticate_repository_interface.dart';
import 'domain/usecases/change_password.dart';
import 'domain/usecases/interfaces/change_password_interface.dart';
import 'domain/usecases/interfaces/post_authenticate_by_login_interface.dart';
import 'domain/usecases/interfaces/remember_password_interface.dart';
import 'domain/usecases/interfaces/send_remember_psw_email_interface.dart';
import 'domain/usecases/interfaces/validate_email_interface.dart';
import 'domain/usecases/post_authenticate_by_login.dart';
import 'domain/usecases/remember_password.dart';
import 'domain/usecases/send_remember_psw_email.dart';
import 'domain/usecases/validate_email.dart';
import 'infra/data/datasources/authenticate_datasource_interface.dart';
import 'infra/data/repositories/authenticate_repository.dart';
import 'infra/external/datasources/authenticate_datasource.dart';
import 'presenter/pages/changePassword/change_psw_controller.dart';
import 'presenter/pages/changePassword/change_psw_page.dart';
import 'presenter/pages/login/login_controller.dart';
import 'presenter/pages/login/login_page.dart';
import 'presenter/pages/validation/code_validation_controller.dart';
import 'presenter/pages/validation/code_validation_page.dart';
import 'presenter/stores/change_psw_store.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController(i(), i(), i(), i())),
    Bind.lazySingleton((i) => CodeValidationController(i(), i(), i())),
    Bind.lazySingleton((i) => ChangePswController(i(), i(), i())),
    Bind.lazySingleton((i) => ChangePswStore()),
    Bind.lazySingleton<IValidateEmail>((i) => ValidateEmail(i())),
    Bind.lazySingleton<ISendRememberPswEmail>((i) => SendRememberPswEmail(i())),
    Bind.lazySingleton<IRememberPassword>((i) => RememberPassword(i())),
    Bind.lazySingleton<IChangePassword>((i) => ChangePassword(i())),
    Bind.lazySingleton<IPostAuthenticateByLogin>(
        (i) => PostAuthenticateByLogin(i())),
    Bind.lazySingleton<IAuthenticateRepository>(
        (i) => AuthenticateRepository(i(), i())),
    Bind.lazySingleton<IAuthenticateDatasource>(
        (i) => AuthenticateDatasource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
    ChildRoute('/codeValidation',
        child: (_, args) => CodeValidationPage(args.data)),
    ChildRoute('/changePsw', child: (_, args) => ChangePswPage()),
  ];
}
