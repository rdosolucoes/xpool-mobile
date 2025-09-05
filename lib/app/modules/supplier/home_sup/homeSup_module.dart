import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/partner_sup_repository_interface.dart';
import 'domain/repositories/reference_sup_repository_interface.dart';
import 'domain/repositories/values_header_sup_repository_interface.dart';
import 'domain/usecases/accept_reference_sup.dart';
import 'domain/usecases/get_partners_sup.dart';
import 'domain/usecases/get_references_sup.dart';
import 'domain/usecases/get_values_header_sup.dart';
import 'domain/usecases/interfaces/accept_reference_sup_interface.dart';
import 'domain/usecases/interfaces/get_partners_sup_interface.dart';
import 'domain/usecases/interfaces/get_references_sup_interface.dart';
import 'domain/usecases/interfaces/get_values_headers_sup_interface.dart';
import 'domain/usecases/interfaces/reject_reference_sup_interface.dart';
import 'domain/usecases/reject_reference_sup.dart';
import 'infra/data/datasources/partner_sup_datasource_interface.dart';
import 'infra/data/datasources/reference_sup_datasource_interface.dart';
import 'infra/data/datasources/values_header_sup_datasource_interface.dart';
import 'infra/data/repositories/partner_sup_repository.dart';
import 'infra/data/repositories/reference_sup_repository.dart';
import 'infra/data/repositories/values_header_sup_repository.dart';
import 'infra/external/datasources/partner_sup_datasource.dart';
import 'infra/external/datasources/reference_sup_datasource.dart';
import 'infra/external/datasources/values_header_sup_datasource.dart';
import 'presenter/pages/homeSup_controller.dart';
import 'presenter/pages/homeSup_page.dart';
import 'presenter/stores/headerSup_store.dart';
import 'presenter/stores/homeSup_store.dart';

class HomeSupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => HomeSupController(i(), i(), i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton((i) => HomeSupStore()),
    Bind.lazySingleton((i) => HeaderSupStore()),
    Bind.lazySingleton<IGetPartnersSup>((i) => GetPartnersSup(i())),
    Bind.lazySingleton<IPartnerSupRepository>((i) => PartnerSupRepository(i())),
    Bind.lazySingleton<IPartnerSupDataSource>((i) => PartnerSupDataSource(i())),
    Bind.lazySingleton<IGetReferencesSup>((i) => GetReferencesSup(i())),
    Bind.lazySingleton<IAcceptReferenceSup>((i) => AcceptReferenceSup(i())),
    Bind.lazySingleton<IRejectReferenceSup>((i) => RejectReferenceSup(i())),
    Bind.lazySingleton<IReferenceSupRepository>(
        (i) => ReferenceSupRepository(i())),
    Bind.lazySingleton<IReferenceSupDataSource>(
        (i) => ReferenceSupDataSource(i())),
    Bind.lazySingleton<IGetValuesHeaderSup>((i) => GetValuesHeaderSup(i())),
    Bind.lazySingleton<IValuesHeaderSupRepository>(
        (i) => ValuesHeaderSupRepository(i())),
    Bind.lazySingleton<IValuesHeaderSupDataSource>(
        (i) => ValuesHeaderSupDataSource(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomeSupPage()),
  ];
}
