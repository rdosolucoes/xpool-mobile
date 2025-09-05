import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/creditCard_response_model.dart';
import '../view_models/creditCard_view_model.dart';

class CreditCardVmStore extends MobXStore<Failure, CreditCardVM> {
  CreditCardVmStore() : super(CreditCardVM());

  void setCreditCards(
      Future<Either<Failure, List<CreditCardResponseModel>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(creditCards: r);
        update(newState);
      },
    );
    setLoading(false);
  }
}
