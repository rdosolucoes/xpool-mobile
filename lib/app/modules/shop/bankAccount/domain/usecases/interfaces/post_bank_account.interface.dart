import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../entities/bank_account_entity.dart';

abstract class IPostBankAccount {
  Future<Either<Failure, ResultModel>> call(BankAccountEntity request);
}
