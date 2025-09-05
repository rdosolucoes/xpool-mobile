import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/partnership_repository_interface.dart';
import 'domain/repositories/shop_repository_interface.dart';
import 'domain/usecases/break_partner_shop.dart';
import 'domain/usecases/cancel_invite_shop.dart';
import 'domain/usecases/create_invite_shop.dart';
import 'domain/usecases/get_all_shops.dart';
import 'domain/usecases/get_cities_shop.dart';
import 'domain/usecases/interfaces/break_partner_shop_interface.dart';
import 'domain/usecases/interfaces/cancel_invite_shop_interface.dart';
import 'domain/usecases/interfaces/create_invite_shop_interface.dart';
import 'domain/usecases/interfaces/get_all_shops_interface.dart';
import 'domain/usecases/interfaces/get_cities_shop_interface.dart';
import 'infra/data/datasources/partnership_datasource.interface.dart';
import 'infra/data/datasources/shop_datasource_interface.dart';
import 'infra/data/repositories/partnership_repository.dart';
import 'infra/data/repositories/shop_repository.dart';
import 'infra/external/datasources/partnership_datasource.dart';
import 'infra/external/datasources/shop_datasource.dart';
import 'presenter/pages/partnershipSup_controller.dart';
import 'presenter/pages/partnershipSup_page.dart';
import 'presenter/stores/filter_partnershipSup_store.dart';
import 'presenter/stores/partnershipSup_store.dart';

class PartnershipSupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) =>
        PartnershipSupController(i(), i(), i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => PartnershipSupStore()),
    Bind.lazySingleton((i) => FilterPartnershipSupStore()),
    Bind.lazySingleton<IGetCitiesShop>((i) => GetCitiesShop(i())),
    Bind.lazySingleton<IGetAllShops>((i) => GetAllShops(i())),
    Bind.lazySingleton<IShopRepository>((i) => ShopRepository(i())),
    Bind.lazySingleton<IShopDatasource>((i) => ShopDataSource(i())),
    Bind.lazySingleton<ICreateInviteShop>((i) => CreateInviteShop(i())),
    Bind.lazySingleton<ICancelInviteShop>((i) => CancelInviteShop(i())),
    Bind.lazySingleton<IBreakPartnerShop>((i) => BreakPartnerShop(i())),
    Bind.lazySingleton<IPartnershipRepository>(
        (i) => PartnershipRepository(i())),
    Bind.lazySingleton<IPartnershipDatasource>(
        (i) => PartnershipDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => PartnershipSupPage()),
  ];
}
