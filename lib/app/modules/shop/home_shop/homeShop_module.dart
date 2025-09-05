import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/partner_shop_repository_interface.dart';
import 'domain/repositories/reference_shop_repository_interface.dart';
import 'domain/repositories/values_repository_interface.dart';
import 'domain/usecases/delete_reference.dart';
import 'domain/usecases/get_partners_shop.dart';
import 'domain/usecases/get_references_shop.dart';
import 'domain/usecases/get_suppliers_by_reference.dart';
import 'domain/usecases/get_values_header.dart';
import 'domain/usecases/interfaces/delete_reference_interface.dart';
import 'domain/usecases/interfaces/get_partners_shop_interface.dart';
import 'domain/usecases/interfaces/get_references_shop_interface.dart';
import 'domain/usecases/interfaces/get_suppliers_by_reference_interface.dart';
import 'domain/usecases/interfaces/get_values_header_interface.dart';
import 'infra/data/datasources/partner_shop_datasource_interface.dart';
import 'infra/data/datasources/reference_shop_datasource_interface.dart';
import 'infra/data/datasources/values_datasource_interface.dart';
import 'infra/data/repositories/partner_shop_repository.dart';
import 'infra/data/repositories/reference_shop_repository.dart';
import 'infra/data/repositories/values_repository.dart';
import 'infra/external/datasources/partner_shop_datasource.dart';
import 'infra/external/datasources/reference_shop_datasource.dart';
import 'infra/external/datasources/values_datasource.dart';
import 'presenter/pages/homeShop_controller.dart';
import 'presenter/pages/homeShop_page.dart';
import 'presenter/stores/headerShop_store.dart';
import 'presenter/stores/homeShop_store.dart';

class HomeShopModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => HomeShopController(i(), i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => HomeShopStore()),
    Bind.lazySingleton((i) => HeaderShopStore()),
    Bind.lazySingleton<IGetReferencesShop>((i) => GetReferencesShop(i())),
    Bind.lazySingleton<IGetSuppliersByReference>(
        (i) => GetSuppliersByReference(i())),
    Bind.lazySingleton<IDeleteReference>((i) => DeleteReference(i())),
    Bind.lazySingleton<IReferenceShopRepository>(
        (i) => ReferenceShopRepository(i())),
    Bind.lazySingleton<IReferenceShopDataSource>(
        (i) => ReferenceShopDataSource(i())),
    Bind.lazySingleton<IGetPartnersShop>((i) => GetPartnersShop(i())),
    Bind.lazySingleton<IPartnerShopRepository>(
        (i) => PartnerShopRepository(i())),
    Bind.lazySingleton<IPartnerShopDataSource>(
        (i) => PartnerShopDataSource(i())),
    Bind.lazySingleton<IGetValuesHeader>((i) => GetValuesHeader(i())),
    Bind.lazySingleton<IValuesRepository>((i) => ValuesRepository(i())),
    Bind.lazySingleton<IValuesDataSource>((i) => ValuesDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomeShopPage()),
  ];
}
