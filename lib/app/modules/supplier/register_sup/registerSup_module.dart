import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/needs/domain/repositories/need_repository_interface.dart';
import '../../../../shared/needs/infra/data/datasource/need_datasource_interface.dart';
import '../../../../shared/needs/infra/data/repositories/need_repository.dart';
import '../../../../shared/needs/infra/external/datasource/need_datasource.dart';
import 'domain/repositories/sup_repository_interface.dart';
import 'domain/usecases/get_needs.dart';
import 'domain/usecases/interfaces/get_needs_interface.dart';
import 'domain/usecases/interfaces/post_sup_interface.dart';
import 'domain/usecases/interfaces/send_code_verify.dart';
import 'domain/usecases/interfaces/validate_email_interface.dart';
import 'domain/usecases/interfaces/validate_form_interface.dart';
import 'domain/usecases/post_sup.dart';
import 'domain/usecases/send_code_verify.dart';
import 'domain/usecases/validate_email.dart';
import 'domain/usecases/validate_form.dart';
import 'infra/data/datasources/sup_datasource_interface.dart';
import 'infra/data/repositories/sup_repository.dart';
import 'infra/external/datasources/sup_datasource.dart';
import 'presenter/pages/register/registerSup_controller.dart';
import 'presenter/pages/register/registerSup_page.dart';
import 'presenter/pages/select_needs/select_needs_sup_controller.dart';
import 'presenter/pages/select_needs/select_needs_sup_page.dart';
import 'presenter/pages/validation/code_validation_sup_controller.dart';
import 'presenter/pages/validation/code_validation_sup_page.dart';
import 'presenter/stores/need_store.dart';
import 'presenter/stores/registerSup_store.dart';

class RegisterSupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NeedStore()),
    Bind.lazySingleton((i) => RegisterSupController(i(), i())),
    Bind.lazySingleton((i) => CodeValidationSupController(i(), i())),
    Bind.lazySingleton((i) => SelectNeedsSupController(
        i.args.data, i(), i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => RegisterSupStore()),
    Bind.lazySingleton<IGetNeeds>((i) => GetNeeds(i())),
    Bind.lazySingleton<INeedRepository>((i) => NeedRepository(i())),
    Bind.lazySingleton<IPostSup>((i) => PostSup(i())),
    Bind.lazySingleton<ISupRepository>((i) => SupRepository(i(), i(), i())),
    Bind.lazySingleton<ISupDatasource>((i) => SupDataSource(i())),
    Bind.lazySingleton<INeedDatasource>((i) => NeedDataSource(i())),
    Bind.lazySingleton<ISendCodeVerify>((i) => SendCodeVerify(i())),
    Bind.lazySingleton<IValidateEmail>((i) => ValidateEmail(i())),
    Bind.lazySingleton<IValidateForm>((i) => ValidateForm(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => RegisterSupPage(),
        transition: TransitionType.fadeIn),
    ChildRoute('/selectNeedsSup',
        child: (_, args) => SelectNeedsSupPage(
              model: args.data,
            ),
        transition: TransitionType.fadeIn),
    ChildRoute('/codeValidationSup',
        child: (_, args) => CodeValidationSupPage(args.data)),
  ];
}
