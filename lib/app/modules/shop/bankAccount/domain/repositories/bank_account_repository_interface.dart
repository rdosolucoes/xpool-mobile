import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../entities/bank_account_entity.dart';

abstract class IBankAccountRepository {
  Future<Either<Failure, BankAccountEntity>> get();
  Future<Either<Failure, ResultModel>> post(BankAccountEntity request);
}
