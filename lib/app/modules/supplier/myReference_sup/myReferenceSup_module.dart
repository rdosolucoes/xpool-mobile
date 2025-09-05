import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/my_reference_sup_repository.dart';
import 'domain/usecases/create_dispute.dart';
import 'domain/usecases/get_my_references.dart';
import 'domain/usecases/interfaces/create_dispute_interface.dart';
import 'domain/usecases/interfaces/get_my_references_interface.dart';
import 'domain/usecases/interfaces/set_done_deal_interface.dart';
import 'domain/usecases/set_done_deal.dart';
import 'infra/data/datasources/my_reference_sup_datasource_interface.dart';
import 'infra/data/repositories/my_reference_sup_repository.dart';
import 'infra/external/datasources/my_reference_sup_datasource.dart';
import 'presenter/pages/myReferenceSup_controller.dart';
import 'presenter/pages/myReferenceSup_page.dart';
import 'presenter/stores/my_reference_sup_store.dart';

class MyReferenceSupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MyReferenceSupController(i(), i(), i(), i())),
    Bind.lazySingleton((i) => MyReferenceSupStore()),
    Bind.lazySingleton<IGetMyReferences>((i) => GetMyReferences(i())),
    Bind.lazySingleton<ISetDoneDeal>((i) => SetDoneDeal(i())),
    Bind.lazySingleton<ICreateDispute>((i) => CreateDispute(i())),
    Bind.lazySingleton<IMyReferenceSupRepository>(
        (i) => MyReferenceSupRepository(i())),
    Bind.lazySingleton<IMyReferenceSupDatasource>(
        (i) => MyReferenceSupDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MyReferenceSupPage()),
  ];
}
