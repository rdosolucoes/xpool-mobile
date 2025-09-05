import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/creditCard_response_model.dart';
import '../repositories/creditCard_repository_interface.dart';
import 'interfaces/get_all_creditCards_interface.dart';

class GetAllCreditCards extends IGetAllCreditCards {
  final ICreditCardRepository _creditCardRepository;

  GetAllCreditCards(this._creditCardRepository);

  @override
  Future<Either<Failure, List<CreditCardResponseModel>>> call() async {
    var result = await _creditCardRepository.getAll();
    return result;
  }
}
