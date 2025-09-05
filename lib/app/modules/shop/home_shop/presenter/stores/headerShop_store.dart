import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/values_header_entity.dart';

class HeaderShopStore extends MobXStore<Failure, ValuesHeaderEntity> {
  HeaderShopStore() : super(ValuesHeaderEntity());

  void setTotalReferences(int v) {
    var newState = state.copyWith(totalReference: v);
    update(newState);
  }

  void setTotalAccept(int v) {
    var newState = state.copyWith(totalAccept: v);
    update(newState);
  }

  void setTotalReprove(int v) {
    var newState = state.copyWith(totalReject: v);
    update(newState);
  }

  void setTotalContest(int v) {
    var newState = state.copyWith(totalContest: v);
    update(newState);
  }

  void setRefPend(int v) {
    var newState = state.copyWith(refpend: v);
    update(newState);
  }

  void setRefAccept(int v) {
    var newState = state.copyWith(refAccept: v);
    update(newState);
  }

  void setRefEpired(int v) {
    var newState = state.copyWith(refExpired: v);
    update(newState);
  }

  void setSaldo(double v) {
    var newState = state.copyWith(saldo: v);
    update(newState);
  }
}
