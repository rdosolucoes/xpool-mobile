import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/either_adapter/dartz_either_adapter.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/sup_entity.dart';

class RegisterSupStore extends MobXStore<Failure, SupEntity> {
  RegisterSupStore() : super(SupEntity());

  void setErrorMsg(String? v) => update(state.copyWith(messageError: v));

  Future<void> setSup(Either<Failure, SupEntity> value) async {
    await executeEither(() async => DartzEitherAdapter(value),
        delay: Duration(milliseconds: 500));
  }

  void setName(String v) {
    var newState = state.copyWith(name: v);
    update(newState);
  }

  void setPhone(String v) {
    var newState = state.copyWith(phone: v);
    update(newState);
  }

  void setEmail(String v) {
    var newState = state.copyWith(email: v);
    update(newState);
  }

  void setState(String v) {
    var newState = state.copyWith(state: v);
    update(newState);
  }

  void setCity(String v) {
    var newState = state.copyWith(city: v);
    update(newState);
  }

  void setStreet(String v) {
    var newState = state.copyWith(street: v);
    update(newState);
  }

  void setDistrict(String v) {
    var newState = state.copyWith(district: v);
    update(newState);
  }

  void setNumber(String v) {
    var newState = state.copyWith(placeNumber: v);
    update(newState);
  }

  void setCep(String v) {
    var newState = state.copyWith(postalCode: v);
    update(newState);
  }

  void setComplement(String v) {
    var newState = state.copyWith(complement: v);
    update(newState);
  }

  void setErrorCep(String v) {
    var newState = state.copyWith(errorCep: v);
    update(newState);
  }

  Future<void> clear() async {
    setError(DefaultFailure(message: ""));
    update(SupEntity());
  }

  Future<void> clearError() async {
    setError(DefaultFailure(message: ""));
  }
}
