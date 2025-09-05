import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../entities/bank_account_entity.dart';
import '../repositories/bank_account_repository_interface.dart';
import 'interfaces/post_bank_account.interface.dart';

class PostBankAccount implements IPostBankAccount {
  final IBankAccountRepository _bankAccountRepository;

  PostBankAccount(this._bankAccountRepository);
  @override
  Future<Either<Failure, ResultModel>> call(BankAccountEntity request) async {
    if (request.validation.isNotEmpty) {
      return Left(DefaultFailure(message: request.validation));
    }

    try {
      return _bankAccountRepository.post(request);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar conta bancária');
    }
  }
}
