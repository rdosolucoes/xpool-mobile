import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/shop_repository_interface.dart';
import 'domain/usecases/interfaces/post_shop_interface.dart';
import 'domain/usecases/interfaces/send_code_verify_interface.dart';
import 'domain/usecases/interfaces/validate_email_interface.dart';
import 'domain/usecases/interfaces/validate_form_interface.dart';
import 'domain/usecases/post_shop.dart';
import 'domain/usecases/send_code_verify.dart';
import 'domain/usecases/validate_email.dart';
import 'domain/usecases/validate_form.dart';
import 'infra/data/datasources/shop_datasource_interface.dart';
import 'infra/data/repositories/shop_repository.dart';
import 'infra/external/datasources/shop_datasource.dart';
import 'presenter/pages/code_validation_shop_controller.dart';
import 'presenter/pages/code_validation_shop_page.dart';
import 'presenter/pages/registerShop_controller.dart';
import 'presenter/pages/registerShop_page.dart';
import 'presenter/stores/registerShop_store.dart';

class RegisterShopModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => RegisterShopController(i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => CodeValidationShopController(i(), i())),
    Bind.lazySingleton((i) => RegisterShopStore()),
    Bind.lazySingleton<IPostShop>((i) => PostShop(i())),
    Bind.lazySingleton<IShopRepository>((i) => ShopRepository(i(), i(), i())),
    Bind.lazySingleton<IShopDatasource>((i) => ShopDataSource(i())),
    Bind.lazySingleton<ISendCodeVerify>((i) => SendCodeVerify(i())),
    Bind.lazySingleton<IValidateEmail>((i) => ValidateEmail(i())),
    Bind.lazySingleton<IValidateForm>((i) => ValidateForm(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => RegisterShopPage()),
    ChildRoute('/codeValidationShop',
        child: (_, args) => CodeValidationShopPage(args.data)),
  ];
}
