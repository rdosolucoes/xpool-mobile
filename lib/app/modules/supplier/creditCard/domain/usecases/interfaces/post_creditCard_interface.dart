import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../entities/creditCard_entity.dart';

abstract class IPostCreditCard {
  Future<Either<Failure, ResultModel>> call(CreditCardEntity request);
}
