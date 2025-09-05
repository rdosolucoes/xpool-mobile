import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/creditCard_entity.dart';

abstract class IGetCreditCard {
  Future<Either<Failure, CreditCardEntity>> call();
}
