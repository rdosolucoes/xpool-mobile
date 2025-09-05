import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/profile_shop_entity.dart';
import '../../../domain/repositories/profile_shop_repository_interface.dart';
import '../../models/profile_shop_model.dart';
import '../datasources/profile_shop_datasource_interface.dart';

class ProfileShopRepository extends IProfileShopRepository {
  final IProfileShopDataSource _dataSource;

  ProfileShopRepository(this._dataSource);

  @override
  Future<Either<Failure, ProfileShopEntity>> get() async {
    try {
      var result = await _dataSource.get();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileShopModel>> postProfile(
      ProfileShopEntity request) async {
    try {
      var model = ProfileShopModel(
          id: request.id,
          image: request.image,
          name: request.name,
          email: request.email,
          phone: request.phone,
          street: request.street,
          placeNumber: request.placeNumber,
          complement: request.complement,
          postalCode: request.postalCode,
          city: request.city,
          state: request.state,
          totalReference: request.totalReference,
          totalAccept: request.totalAccept,
          totalReject: request.totalReject);

      final result = await _dataSource.postProfile(model);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
