import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/needs/domain/repositories/need_repository_interface.dart';
import '../../../../shared/needs/infra/data/datasource/need_datasource_interface.dart';
import '../../../../shared/needs/infra/data/repositories/need_repository.dart';
import '../../../../shared/needs/infra/external/datasource/need_datasource.dart';
import 'domain/repositories/profile_sup_repository_interface.dart';
import 'domain/usecases/get_needs_sup.dart';
import 'domain/usecases/get_profile_sup.dart';
import 'domain/usecases/interface/get_needs_sup_interface.dart';
import 'domain/usecases/interface/get_profile_sup_interface.dart';
import 'domain/usecases/interface/post_profile_sup_interface.dart';
import 'domain/usecases/post_profile_sup.dart';
import 'infra/data/datasources/profile_sup_datasource_interface.dart';
import 'infra/data/repositories/profile_sup_repository.dart';
import 'infra/external/datasources/profile_sup_datasource.dart';
import 'presenter/pages/edit_profileSup_controller.dart';
import 'presenter/pages/edit_profileSup_page.dart';
import 'presenter/pages/profileSup_controller.dart';
import 'presenter/pages/profileSup_page.dart';
import 'presenter/stores/profileSup_store.dart';

class ProfileSupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileSupController(i(), i(), i())),
    Bind.lazySingleton((i) => EditProfileSupController(i(), i(), i(), i())),
    Bind.lazySingleton((i) => ProfileSupStore()),
    Bind.lazySingleton<IGetProfileSup>((i) => GetProfileSup(i())),
    Bind.lazySingleton<IGetNeedsSup>((i) => GetNeedsSup(i())),
    Bind.lazySingleton<INeedRepository>((i) => NeedRepository(i())),
    Bind.lazySingleton<INeedDatasource>((i) => NeedDataSource(i())),
    Bind.lazySingleton<IPostProfileSup>((i) => PostProfileSup(i())),
    Bind.lazySingleton<IProfileSupRepository>((i) => ProfileSupRepository(i())),
    Bind.lazySingleton<IProfileSupDataSource>((i) => ProfileSupDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProfileSupPage()),
    ChildRoute('/editProfileSupPage',
        child: (_, args) => EditProfileSupPage(),
        transition: TransitionType.fadeIn),
  ];
}
