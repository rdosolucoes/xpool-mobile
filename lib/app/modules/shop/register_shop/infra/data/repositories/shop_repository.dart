import 'package:dartz/dartz.dart';

import '../../../../../../../shared/auth/local_storage/interfaces/auth_repository_interface.dart';
import '../../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/shop_entity.dart';
import '../../../domain/repositories/shop_repository_interface.dart';
import '../../models/shop_model.dart';
import '../datasources/shop_datasource_interface.dart';

class ShopRepository implements IShopRepository {
  final IShopDatasource _dataSource;
  final AuthStore _authStore;
  final IAuthLocalStorage _localStorage;

  ShopRepository(this._dataSource, this._authStore, this._localStorage);

  @override
  Future<Either<Failure, ShopModel>> postShop(ShopEntity request) async {
    try {
      var model = ShopModel(
        name: request.name,
        email: request.email,
        postalCode: request.postalCode,
        street: request.street,
        city: request.city,
        state: request.state,
        district: request.district,
        placeNumber: request.placeNumber,
        complement: request.complement,
        phone: request.phone,
      );

      final result = await _dataSource.postShop(model);

      if (result.cityId > 0) {
        _authStore.setCityId(result.cityId);
        _localStorage.update(_authStore.state);
      }

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
