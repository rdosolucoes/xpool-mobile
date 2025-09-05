import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/needs/domain/repositories/need_repository_interface.dart';
import '../../../../shared/needs/infra/data/datasource/need_datasource_interface.dart';
import '../../../../shared/needs/infra/data/repositories/need_repository.dart';
import '../../../../shared/needs/infra/external/datasource/need_datasource.dart';
import '../home_shop/homeShop_module.dart';
import '../menu_shop/menuShop_module.dart';
import '../notification_shop/notificationShop_module.dart';
import '../partnership_shop/partnershipShop_module.dart';
import '../reference_shop/referenceShop_module.dart';
import 'domain/usecases/get_needs.dart';
import 'domain/usecases/interfaces/get_needs_interface.dart';
import 'presenter/pages/startShop_controller.dart';
import 'presenter/pages/startShop_page.dart';
import 'presenter/stores/need_store.dart';
import 'presenter/stores/startShop_store.dart';

class StartShopModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IGetNeeds>((i) => GetNeeds((i()))),
    Bind.lazySingleton((i) => StartShopController(i(), i(), i(), i())),
    Bind.lazySingleton((i) => StartShopStore()),
    Bind.lazySingleton((i) => NeedStore()),
    Bind.lazySingleton<INeedRepository>((i) => NeedRepository(i())),
    Bind.lazySingleton<INeedDatasource>((i) => NeedDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => StartShopPage(), children: [
      ModuleRoute('/homeShop',
          module: HomeShopModule(), transition: TransitionType.fadeIn),
      ModuleRoute('/referenceShop',
          module: ReferenceShopModule(), transition: TransitionType.fadeIn),
      ModuleRoute('/partnershipShop',
          module: PartnershipShopModule(), transition: TransitionType.fadeIn),
      ModuleRoute('/notificationShop',
          module: NotificationShopModule(), transition: TransitionType.fadeIn),
      ModuleRoute('/menuShop',
          module: MenuShopModule(), transition: TransitionType.fadeIn),
    ])
  ];
}
