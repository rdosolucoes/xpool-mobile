import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/creditCard_repository_interface.dart';
import 'interfaces/delete_creditCard_interface.dart';

class DeleteCreditCard implements IDeleteCreditCard {
  final ICreditCardRepository _bankAccountRepository;

  DeleteCreditCard(this._bankAccountRepository);
  @override
  Future<Either<Failure, ResultModel>> call(String cardId) async {
    try {
      return _bankAccountRepository.delete(cardId);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar conta bancária');
    }
  }
}
