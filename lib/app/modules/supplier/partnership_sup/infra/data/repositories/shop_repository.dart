import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/filter_partnershipSup_entity.dart';
import '../../../domain/entities/shop_entity.dart';
import '../../../domain/repositories/shop_repository_interface.dart';
import '../datasources/shop_datasource_interface.dart';

class ShopRepository implements IShopRepository {
  // final IShopDatasource _datasource;

  final IShopDatasource _datasource;

  ShopRepository(this._datasource);

  @override
  Future<Either<Failure, List<ShopEntity>>> get(
      FilterPartnershipSupEntity filter) async {
    try {
      var result = <ShopEntity>[];
      var listShop = await _datasource.get(filter);

      result = listShop
          .map((e) => ShopEntity(
              id: e.id,
              name: e.name,
              city: e.city,
              status: e.status,
              photo: e.photo))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
