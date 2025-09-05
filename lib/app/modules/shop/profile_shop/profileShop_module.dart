import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/profile_shop_repository_interface.dart';
import 'domain/usecases/get_profile_shop.dart';
import 'domain/usecases/interface/get_profile_shop_interface.dart';
import 'domain/usecases/interface/post_profile_shop_interface.dart';
import 'domain/usecases/post_profile_shop.dart';
import 'infra/data/datasources/profile_shop_datasource_interface.dart';
import 'infra/data/repositories/profile_shop_repository.dart';
import 'infra/external/datasources/profile_shop_datasource.dart';
import 'presenter/pages/edit_profileShop_controller.dart';
import 'presenter/pages/edit_profileShop_page.dart';
import 'presenter/pages/profileShop_controller.dart';
import 'presenter/pages/profileShop_page.dart';
import 'presenter/stores/profileShop_store.dart';

class ProfileShopModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileShopController(i(), i())),
    Bind.lazySingleton((i) => EditProfileShopController(i(), i(), i(), i())),
    Bind.lazySingleton((i) => ProfileShopStore()),
    Bind.lazySingleton<IGetProfileShop>((i) => GetProfileShop(i())),
    Bind.lazySingleton<IPostProfileShop>((i) => PostProfileShop(i())),
    Bind.lazySingleton<IProfileShopRepository>(
        (i) => ProfileShopRepository(i())),
    Bind.lazySingleton<IProfileShopDataSource>(
        (i) => ProfileShopDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProfileShopPage()),
    ChildRoute('/editProfileShopPage',
        child: (_, args) => EditProfileShopPage(
              model: args.data,
            ),
        transition: TransitionType.fadeIn),
  ];
}
