import 'package:dartz/dartz.dart';
import 'package:mobx_triple/mobx_triple.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../domain/entities/shop_entity.dart';
import '../view_models/sup_view_model.dart';

class PartnershipSupStore extends MobXStore<Failure, SupVM> {
  PartnershipSupStore() : super(SupVM());

  void setFilter(String value) {
    var newState = state.copyWith(filter: value);
    execute(() async => newState);
  }

  void setStatus(int index) {
    var shops = state.shopFiltered;
    shops[index].status = shops[index].status == -1 ? 0 : -1;
    var newState = state.copyWith(shops: shops);
    update(newState);
  }

  void setShops(Future<Either<Failure, List<ShopEntity>>> value) async {
    setLoading(true);
    var result = await value;

    result.fold(
      setError,
      (r) {
        var newState = state.copyWith(shops: r);
        update(newState);
      },
    );
    setLoading(false);
  }

  void startLoading() {
    setLoading(true);
  }

  void stopLoading() {
    setLoading(false);
  }
}
