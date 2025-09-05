import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/reference_repository_interface.dart';
import 'domain/repositories/supplier_reference_repository_interface.dart';
import 'domain/usecases/create_reference.dart';
import 'domain/usecases/get_reference_suppliers.dart';
import 'domain/usecases/interfaces/create_reference_interface.dart';
import 'domain/usecases/interfaces/get_reference_suppliers_interface.dart';
import 'infra/data/datasources/reference_datasource_interface.dart';
import 'infra/data/datasources/supplier_reference_datasource_interface.dart';
import 'infra/data/repositories/reference_repository.dart';
import 'infra/data/repositories/supplier_reference_repository.dart';
import 'infra/external/datasources/reference_datasource.dart';
import 'infra/external/datasources/supplier_reference_datasource.dart';
import 'presenter/pages/referenceShop_controller.dart';
import 'presenter/pages/referenceShop_page.dart';
import 'presenter/stores/referenceShop_store.dart';
import 'presenter/stores/supplierReferenceShop_store.dart';

class ReferenceShopModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => ReferenceShopController(i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => SupplierReferenceShopStore()),
    Bind.lazySingleton((i) => ReferenceShopStore()),
    Bind.lazySingleton<IGetReferenceSuppliers>(
        (i) => GetReferenceSuppliers((i()))),
    Bind.lazySingleton<ISupplierReferenceRepository>(
        (i) => SupplierReferenceRepository(i())),
    Bind.lazySingleton<ISupplierReferenceDatasource>(
        (i) => SupplierReferenceDataSource(i())),
    Bind.lazySingleton<ICreateReference>((i) => CreateReference((i()))),
    Bind.lazySingleton<IReferenceRepository>((i) => ReferenceRepository(i())),
    Bind.lazySingleton<IReferenceDatasource>((i) => ReferenceDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ReferenceShopPage()),
  ];
}
