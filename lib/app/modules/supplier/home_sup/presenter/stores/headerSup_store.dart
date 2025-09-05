import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/values_header_sup_entity.dart';

class HeaderSupStore extends MobXStore<Failure, ValuesHeaderSupEntity> {
  HeaderSupStore() : super(ValuesHeaderSupEntity());

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

  void setRefValue(double v) {
    var newState = state.copyWith(refValue: v);
    update(newState);
  }

  void setCardDefault(String v) {
    var newState = state.copyWith(cardDefault: v);
    update(newState);
  }
}
