import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/dispute_repository_interface.dart';
import 'domain/usecases/approve_dispute.dart';
import 'domain/usecases/disapprove_dispute.dart';
import 'domain/usecases/get_dispute.dart';
import 'infra/data/datasources/dispute_datasource_interface.dart';
import 'infra/data/repositories/dispute_repository.dart';
import 'infra/external/dispute_datasource.dart';
import 'presenter/pages/dispute_controller.dart';
import 'presenter/pages/dispute_page.dart';
import 'presenter/stores/dispute_store.dart';

class DisputeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DisputeController(i(), i(), i(), i())),
    Bind.lazySingleton((i) => DisputeStore()),
    Bind.lazySingleton<IDisputeRepository>((i) => DisputeRepository(i())),
    Bind.lazySingleton<IDisputeDataSource>((i) => DisputeDataSource(i())),
    Bind.lazySingleton<GetDispute>((i) => GetDispute(i())),
    Bind.lazySingleton<ApproveDispute>((i) => ApproveDispute(i())),
    Bind.lazySingleton<DisapproveDispute>((i) => DisapproveDispute(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DisputePage(args.data)),
  ];
}
