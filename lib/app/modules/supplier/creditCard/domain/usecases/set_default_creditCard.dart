import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/creditCard_repository_interface.dart';
import 'interfaces/set_default_creditCard_interface.dart';

class SetDefaultCreditCard implements ISetDefaultCreditCard {
  final ICreditCardRepository _bankAccountRepository;

  SetDefaultCreditCard(this._bankAccountRepository);
  @override
  Future<Either<Failure, ResultModel>> call(String cardId) async {
    try {
      return _bankAccountRepository.setDefault(cardId);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar conta bancária');
    }
  }
}
