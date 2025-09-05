import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/creditCard_entity.dart';
import '../repositories/creditCard_repository_interface.dart';
import 'interfaces/get_creditCard_interface.dart';

class GetCreditCard extends IGetCreditCard {
  final ICreditCardRepository _bankAccountRepository;

  GetCreditCard(this._bankAccountRepository);

  @override
  Future<Either<Failure, CreditCardEntity>> call() async {
    var result = await _bankAccountRepository.get();
    return result;
  }
}
