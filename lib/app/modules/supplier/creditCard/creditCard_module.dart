import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/creditCard_repository_interface.dart';
import 'domain/usecases/delete_creditCard.dart';
import 'domain/usecases/get_all_creditCards.dart';
import 'domain/usecases/get_creditCard.dart';
import 'domain/usecases/interfaces/delete_creditCard_interface.dart';
import 'domain/usecases/interfaces/get_all_creditCards_interface.dart';
import 'domain/usecases/interfaces/get_creditCard_interface.dart';
import 'domain/usecases/interfaces/post_creditCard_interface.dart';
import 'domain/usecases/interfaces/set_default_creditCard_interface.dart';
import 'domain/usecases/post_creditCard.dart';
import 'domain/usecases/set_default_creditCard.dart';
import 'infra/data/datasources/creditCard_interface.dart';
import 'infra/data/repositories/creditCard_repository.dart';
import 'infra/external/datasources/creditCard_datasource.dart';
import 'presenter/pages/creditCard_controller.dart';
import 'presenter/pages/creditCard_page.dart';
import 'presenter/stores/creditCard_store.dart';
import 'presenter/stores/creditCard_vm_store.dart';

class CreditCardModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CreditCardStore()),
    Bind.lazySingleton((i) => CreditCardVmStore()),
    Bind.lazySingleton(
        (i) => CreditCardController(i(), i(), i(), i(), i(), i())),
    Bind.lazySingleton<ICreditCardRepository>((i) => CreditCardRepository(i())),
    Bind.lazySingleton<ICreditCardDataSource>((i) => CreditCardDataSource(i())),
    Bind.lazySingleton<IGetCreditCard>((i) => GetCreditCard(i())),
    Bind.lazySingleton<IGetAllCreditCards>((i) => GetAllCreditCards(i())),
    Bind.lazySingleton<IPostCreditCard>((i) => PostCreditCard(i())),
    Bind.lazySingleton<IDeleteCreditCard>((i) => DeleteCreditCard(i())),
    Bind.lazySingleton<ISetDefaultCreditCard>((i) => SetDefaultCreditCard(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CreditCardPage()),
  ];
}
