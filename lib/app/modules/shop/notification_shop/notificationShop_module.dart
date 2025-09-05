import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/notificationShop_repository_interface.dart';
import 'domain/usecases/confirm_invite_sup.dart';
import 'domain/usecases/get_shop_notifications.dart';
import 'domain/usecases/interfaces/confirm_invite_sup_interface.dart';
import 'domain/usecases/interfaces/get_shop_notifications_interface.dart';
import 'domain/usecases/interfaces/reject_invite_sup_interface.dart';
import 'domain/usecases/reject_invite_sup.dart';
import 'infra/data/datasources/notificationShop_datasource_interface.dart';
import 'infra/data/repositories/notificationShop_repository.dart';
import 'infra/external/datasources/notificationShop_datasource.dart';
import 'presenter/pages/notificationShop_controller.dart';
import 'presenter/pages/notificationShop_page.dart';
import 'presenter/stores/notificationShop_store.dart';

class NotificationShopModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NotificationShopController(i(), i(), i(),i(),i())),
    Bind.lazySingleton((i) => NotificationShopStore()),
    Bind.lazySingleton<IGetShopNotifications>((i) => GetShopNotifications(i())),
    Bind.lazySingleton<IConfirmInviteSup>((i) => ConfirmInviteSup(i())),
    Bind.lazySingleton<IRejectInviteSup>((i) => RejectInviteSup(i())),
    Bind.lazySingleton<INotificationShopRepository>(
        (i) => NotificationShopRepository(i())),
    Bind.lazySingleton<INotificationShopDatasource>(
        (i) => NotificationShopDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => NotificationShopPage()),
  ];
}
