import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/partner_shop_entity.dart';
import '../../../domain/repositories/partner_shop_repository_interface.dart';
import '../datasources/partner_shop_datasource_interface.dart';

class PartnerShopRepository implements IPartnerShopRepository {
  // final IPartnerShopDatasource _datasource;

  final IPartnerShopDataSource _datasource;

  PartnerShopRepository(this._datasource);

  @override
  Future<Either<Failure, List<PartnerShopEntity>>> get() async {
    try {
      var result = <PartnerShopEntity>[];
      var listPartnerShop = await _datasource.get();

      result = listPartnerShop
          .map((e) => PartnerShopEntity(
              id: e.id,
              name: e.name,
              city: e.city,
              status: e.status,
              photo: e.photo,
              need: e.need))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
