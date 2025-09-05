import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/bank_account_entity.dart';

abstract class IGetBankAccount {
  Future<Either<Failure, BankAccountEntity>> call();
}
