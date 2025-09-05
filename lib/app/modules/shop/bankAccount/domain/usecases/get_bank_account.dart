import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/bank_account_entity.dart';
import '../repositories/bank_account_repository_interface.dart';
import 'interfaces/get_bank_account_interface.dart';

class GetBankAccount extends IGetBankAccount {
  final IBankAccountRepository _bankAccountRepository;

  GetBankAccount(this._bankAccountRepository);

  @override
  Future<Either<Failure, BankAccountEntity>> call() async {
    var result = await _bankAccountRepository.get();
    return result;
  }
}
