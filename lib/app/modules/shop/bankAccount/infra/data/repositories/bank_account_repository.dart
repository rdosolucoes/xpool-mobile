import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../domain/entities/bank_account_entity.dart';
import '../../../domain/repositories/bank_account_repository_interface.dart';
import '../../models/bank_account_model.dart';
import '../datasources/bank_account_datasource_interface.dart';

class BankAccountRepository extends IBankAccountRepository {
  final IBankAccountDataSource _dataSource;

  BankAccountRepository(this._dataSource);

  @override
  Future<Either<Failure, BankAccountEntity>> get() async {
    try {
      var result = await _dataSource.get();

      /* var result = BankAccountModel(
          holderName: "Rafael Domingues",
          bankCode: "001",
          bankName: "001 - BCO DO BRASIL S.A",
          accountNumber: "54135",
          accountCheckDigit: "2",
          branchNumber: "0319",
          branchCheckDigit: "0",
          holderDocument: "370.249.348-40",
          holderType: "company",
          type: "saving");*/

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResultModel>> post(BankAccountEntity request) async {
    try {
      var model = BankAccountModel(
        holderName: request.holderName,
        bankCode: request.bankCode,
        bankName: request.bankName,
        branchNumber: request.branchNumber,
        branchCheckDigit: request.branchCheckDigit,
        accountNumber: request.accountNumber,
        accountCheckDigit: request.accountCheckDigit,
        holderType: request.holderType,
        holderDocument: request.holderDocument,
        type: request.type,
      );

      final result = await _dataSource.post(model);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
