import 'package:encrypt/encrypt.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/creditCard_entity.dart';

class CreditCardStore extends MobXStore<Failure, CreditCardEntity> {
  CreditCardStore() : super(CreditCardEntity());

  void setHolderName(Encrypted? v) {
    var newState = state.copyWith(holderName: v);
    update(newState);
  }

  void setNumber(Encrypted? v) {
    var newState = state.copyWith(number: v);
    update(newState);
  }

  void setValidateDate(Encrypted? v) {
    var newState = state.copyWith(validateDate: v);
    update(newState);
  }

  void setCvv(Encrypted? v) {
    var newState = state.copyWith(cvv: v);
    update(newState);
  }

  void setBrand(String v) {
    var newState = state.copyWith(brand: v);
    update(newState);
  }
}
