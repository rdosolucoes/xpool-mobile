import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../infra/models/creditCard_response_model.dart';

abstract class IGetAllCreditCards {
  Future<Either<Failure, List<CreditCardResponseModel>>> call();
}
