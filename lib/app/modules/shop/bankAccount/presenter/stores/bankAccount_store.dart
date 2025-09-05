import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/either_adapter/dartz_either_adapter.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/bank_account_entity.dart';

class BankAccountStore extends MobXStore<Failure, BankAccountEntity> {
  BankAccountStore() : super(BankAccountEntity());

  Future<void> setBankAccount(Either<Failure, BankAccountEntity> value) async {
    setLoading(true);
    await executeEither(() async => DartzEitherAdapter(value),
        delay: Duration(milliseconds: 500));
    setLoading(false);
  }

  void setHolderName(String v) {
    var newState = state.copyWith(holderName: v);
    update(newState);
  }

  void setBankCode(String v) {
    var newState = state.copyWith(bankCode: v);
    update(newState);
  }

  void setBankName(String v) {
    var newState = state.copyWith(bankName: v);
    update(newState);
  }

  void setBranchNumber(String v) {
    var newState = state.copyWith(branchNumber: v);
    update(newState);
  }

  void setBranchCheckDigit(String v) {
    var newState = state.copyWith(branchCheckDigit: v);
    update(newState);
  }

  void setAccountNumber(String? v) {
    var newState = state.copyWith(accountNumber: v);
    update(newState);
  }

  void setAccountCheckDigit(String? v) {
    var newState = state.copyWith(accountCheckDigit: v);
    update(newState);
  }

  void setHolderType(String? v) {
    var newState = state.copyWith(holderType: v);
    update(newState);
  }

  void setHolderDocument(String? v) {
    var newState = state.copyWith(holderDocument: v);
    update(newState);
  }

  void setType(String? v) {
    var newState = state.copyWith(type: v);
    update(newState);
  }

  Future<void> clear() async {
    setError(DefaultFailure(message: ""));
    update(BankAccountEntity());
  }
}
