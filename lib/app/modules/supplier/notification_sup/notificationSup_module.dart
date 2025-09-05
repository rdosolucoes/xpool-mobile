import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/notificationSup_repository_interface.dart';
import 'domain/usecases/confirm_invite_shop.dart';
import 'domain/usecases/get_sup_notifications.dart';
import 'domain/usecases/interfaces/confirm_invite_shop_interface.dart';
import 'domain/usecases/interfaces/get_sup_notifications_interface.dart';
import 'domain/usecases/interfaces/reject_invite_shop_interface.dart';
import 'domain/usecases/reject_invite_shop.dart';
import 'infra/data/datasources/notificationSup_datasource_interface.dart';
import 'infra/data/repositories/notificationSup_repository.dart';
import 'infra/external/datasources/notificationSup_datasource.dart';
import 'presenter/pages/notificationSup_controller.dart';
import 'presenter/pages/notificationSup_page.dart';
import 'presenter/stores/notificationSup_store.dart';

class NotificationSupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => NotificationSupController(i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => NotificationSupStore()),
    Bind.lazySingleton<IGetSupNotifications>((i) => GetSupNotifications(i())),
    Bind.lazySingleton<IConfirmInviteShop>((i) => ConfirmInviteShop(i())),
    Bind.lazySingleton<IRejectInviteShop>((i) => RejectInviteShop(i())),
    Bind.lazySingleton<INotificationSupRepository>(
        (i) => NotificationSupRepository(i())),
    Bind.lazySingleton<INotificationSupDatasource>(
        (i) => NotificationSupDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => NotificationSupPage()),
  ];
}
