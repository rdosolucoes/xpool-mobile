import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../entities/creditCard_entity.dart';
import '../repositories/creditCard_repository_interface.dart';
import 'interfaces/post_creditCard_interface.dart';

class PostCreditCard implements IPostCreditCard {
  final ICreditCardRepository _bankAccountRepository;

  PostCreditCard(this._bankAccountRepository);
  @override
  Future<Either<Failure, ResultModel>> call(CreditCardEntity request) async {
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
