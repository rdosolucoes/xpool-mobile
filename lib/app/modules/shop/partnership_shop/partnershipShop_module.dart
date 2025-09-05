import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/needs/domain/repositories/need_repository_interface.dart';
import '../../../../shared/needs/infra/data/datasource/need_datasource_interface.dart';
import '../../../../shared/needs/infra/data/repositories/need_repository.dart';
import '../../../../shared/needs/infra/external/datasource/need_datasource.dart';
import 'domain/repositories/partnership_repository_interface.dart';
import 'domain/repositories/supplier_repository_interface.dart';
import 'domain/usecases/break_partner_supplier.dart';
import 'domain/usecases/cancel_invite_supplier.dart';
import 'domain/usecases/create_invite_supplier.dart';
import 'domain/usecases/get_all_suppliers.dart';
import 'domain/usecases/get_cities_sup.dart';
import 'domain/usecases/get_needs.dart';
import 'domain/usecases/interfaces/break_partner_supplier_interface.dart';
import 'domain/usecases/interfaces/cancel_invite_supplier_interface.dart';
import 'domain/usecases/interfaces/create_invite_supplier_interface.dart';
import 'domain/usecases/interfaces/get_all_suppliers_interface.dart';
import 'domain/usecases/interfaces/get_cities_sup_interface.dart';
import 'domain/usecases/interfaces/get_needs_interface.dart';
import 'infra/data/datasources/partnership_datasource.interface.dart';
import 'infra/data/datasources/supplier_datasource_interface.dart';
import 'infra/data/repositories/partnership_repository.dart';
import 'infra/data/repositories/supplier_repository.dart';
import 'infra/external/datasources/partnership_datasource.dart';
import 'infra/external/datasources/supplier_datasource.dart';
import 'presenter/pages/partnershipShop_controller.dart';
import 'presenter/pages/partnershipShop_page.dart';
import 'presenter/stores/filter_partnershipShop_store.dart';
import 'presenter/stores/partnershipShop_store.dart';

class PartnershipShopModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) =>
        PartnershipShopController(i(), i(), i(), i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => PartnershipShopStore()),
    Bind.lazySingleton((i) => FilterPartnershipShopStore()),
    Bind.lazySingleton<IGetNeeds>((i) => GetNeeds(i())),
    Bind.lazySingleton<IGetAllSuppliers>((i) => GetAllSuppliers(i())),
    Bind.lazySingleton<IGetCitiesSup>((i) => GetCitiesSup(i())),
    Bind.lazySingleton<ISupplierRepository>((i) => SupplierRepository(i())),
    Bind.lazySingleton<ISupplierDatasource>((i) => SupplierDataSource(i())),
    Bind.lazySingleton<ICreateInviteSupplier>((i) => CreateInviteSupplier(i())),
    Bind.lazySingleton<ICancelInviteSupplier>((i) => CancelInviteSupplier(i())),
    Bind.lazySingleton<IBreakPartnerSupplier>((i) => BreakPartnerSupplier(i())),
    Bind.lazySingleton<IPartnershipRepository>(
        (i) => PartnershipRepository(i())),
    Bind.lazySingleton<IPartnershipDatasource>(
        (i) => PartnershipDataSource(i())),
    Bind.lazySingleton<INeedRepository>((i) => NeedRepository(i())),
    Bind.lazySingleton<INeedDatasource>((i) => NeedDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => PartnershipShopPage()),
  ];
}
