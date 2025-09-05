import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/either_adapter/dartz_either_adapter.dart';
import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/change_psw_entity.dart';
import '../../infra/models/change_psw_model.dart';

class ChangePswStore extends MobXStore<Failure, ChangePswEntity> {
  ChangePswStore() : super(ChangePswEntity());

  //void setErrorMsg(String? v) => update(state.copyWith(messageError: v));

  void setPassword(String v) {
    var newState = state.copyWith(password: v);
    update(newState);
  }

  void setConfirmPassword(String v) {
    var newState = state.copyWith(confirmPassword: v);
    update(newState);
  }

  Future<void> setChangePassword(Either<Failure, ChangePswModel> value) async {
    await executeEither(() async => DartzEitherAdapter(value),
        delay: Duration(milliseconds: 500));
  }

  Future<void> clear() async {
    setError(DefaultFailure(message: ""));
    update(ChangePswEntity());
  }
}
