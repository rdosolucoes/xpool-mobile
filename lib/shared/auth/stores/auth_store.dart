import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../auth/models/auth_model.dart';
import '../../helpers/either_adapter/dartz_either_adapter.dart';
import '../../helpers/enum.dart';
import '../../helpers/errors.dart';

class AuthStore extends MobXStore<Failure, AuthModel> {
  AuthStore() : super(AuthModel());

  void setErrorMsg(String? v) => update(state.copyWith(messageError: v));

  void setUserName(String v) {
    var newState = state.copyWith(userName: v);
    update(newState);
  }

  void setPassword(String v) {
    var newState = state.copyWith(password: v);
    update(newState);
  }

  void setImage(String v) {
    var newState = state.copyWith(image: v);
    update(newState);
  }

  Future<void> setLogin(Either<Failure, AuthModel> value) async {
    await executeEither(() async => DartzEitherAdapter(value),
        delay: Duration(milliseconds: 500));
  }

  Future<void> clear() async {
    setError(DefaultFailure(message: ""));
    update(AuthModel());
  }

  void setSignMode(v) {
    var newState = state.copyWith(isSignMode: v);
    update(newState);
  }

  void setTypeUser(v) {
    var newState = state.copyWith(typeUser: v);
    update(newState);
  }

  void setName(v) {
    var newState = state.copyWith(name: v);
    update(newState);
  }

  void setPlayerId(v) {
    var newState = state.copyWith(playerId: v);
    update(newState);
  }

  void setConfirmPassword(String v) {
    var newState = state.copyWith(confirmPassword: v);
    update(newState);
  }

  void setEmailValidate(v) {
    var newState = state.copyWith(emailValidate: v);
    update(newState);
  }

  void setIsEmployee(v) {
    var newState = state.copyWith(isEmployee: v);
    update(newState);
  }

  bool? isEmailValidate() {
    return state.emailValidate;
  }

  void setCityId(v) {
    var newState = state.copyWith(cityId: v);
    update(newState);
  }

  void setPendingDelete(v) {
    var newState = state.copyWith(pendingDelete: v);
    update(newState);
  }

  ETypeUser getTypeUser() {
    if (state.typeUser == 1) {
      return ETypeUser.shop;
    } else {
      if (state.typeUser == 2) {
        return ETypeUser.supplier;
      }
    }
    return ETypeUser.undefined;
  }
}
