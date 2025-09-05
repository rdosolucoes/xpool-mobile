import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../datasource/city_datasource.dart';
import '../models/dropdown_model.dart';

class CityRepository {
  // final INotificationShopDatasource _datasource;

  final CityDataSource _datasource;

  CityRepository(this._datasource);

  Future<Either<Failure, List<DropdownModel>>> getCitiesUf(int stateId) async {
    try {
      var result = <DropdownModel>[];
      var listCity = await _datasource.getCitiesUf(stateId);

      result = listCity
          .map((e) => DropdownModel(
                id: e.id,
                name: e.name,
              ))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, List<DropdownModel>>> getCitiesSup() async {
    try {
      var result = <DropdownModel>[];
      var listCity = await _datasource.getCitiesSup();

      result = listCity
          .map((e) => DropdownModel(
                id: e.id,
                name: e.name,
              ))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, List<DropdownModel>>> getCitiesShop() async {
    try {
      var result = <DropdownModel>[];
      var listCity = await _datasource.getCitiesShop();

      result = listCity
          .map((e) => DropdownModel(
                id: e.id,
                name: e.name,
              ))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
