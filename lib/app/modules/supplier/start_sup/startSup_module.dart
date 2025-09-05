import 'package:flutter_modular/flutter_modular.dart';

import '../home_sup/homeSup_module.dart';
import '../menu_sup/menuSup_module.dart';
import '../myReference_sup/myReferenceSup_module.dart';
import '../notification_sup/notificationSup_module.dart';
import '../partnership_sup/partnershipSup_module.dart';
import 'presenter/pages/startSup_controller.dart';
import 'presenter/pages/startSup_page.dart';
import 'presenter/stores/startSup_store.dart';

class StartSupModule extends Module {
  @override
  List<Module> get imports => [
        HomeSupModule(),
        PartnershipSupModule(),
        MyReferenceSupModule(),
        NotificationSupModule(),
        MenuSupModule()
      ];

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => StartSupController(i(), i())),
        Bind.lazySingleton((i) => StartSupStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => StartSupPage(), children: [
          ModuleRoute('/homeSup',
              module: HomeSupModule(), transition: TransitionType.fadeIn),
          ModuleRoute('/partnershipSup',
              module: PartnershipSupModule(),
              transition: TransitionType.fadeIn),
          ModuleRoute('/myReferenceSup',
              module: MyReferenceSupModule(),
              transition: TransitionType.fadeIn),
          ModuleRoute('/notificationSup',
              module: NotificationSupModule(),
              transition: TransitionType.fadeIn),
          ModuleRoute('/menuSup',
              module: MenuSupModule(), transition: TransitionType.fadeIn),
        ])
      ];
}
