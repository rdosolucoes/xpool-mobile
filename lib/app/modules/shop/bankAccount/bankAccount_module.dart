import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/bank_account_repository_interface.dart';
import 'domain/usecases/get_bank_account.dart';
import 'domain/usecases/interfaces/get_bank_account_interface.dart';
import 'domain/usecases/interfaces/post_bank_account.interface.dart';
import 'domain/usecases/post_bank_account.dart';
import 'infra/data/datasources/bank_account_datasource_interface.dart';
import 'infra/data/repositories/bank_account_repository.dart';
import 'infra/external/datasources/bank_account_datasource.dart';
import 'presenter/pages/bankAccount_controller.dart';
import 'presenter/pages/bankAccount_page.dart';
import 'presenter/stores/bankAccount_store.dart';

class BankAccountModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => BankAccountStore()),
    Bind.lazySingleton((i) => BankAccountController(i(), i(), i())),
    Bind.lazySingleton<IBankAccountRepository>(
        (i) => BankAccountRepository(i())),
    Bind.lazySingleton<IBankAccountDataSource>(
        (i) => BankAccountDataSource(i())),
    Bind.lazySingleton<IGetBankAccount>((i) => GetBankAccount(i())),
    Bind.lazySingleton<IPostBankAccount>((i) => PostBankAccount(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => BankAccountPage()),
  ];
}
