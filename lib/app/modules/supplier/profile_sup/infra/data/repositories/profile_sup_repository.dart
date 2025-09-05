import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/need_sup_entity.dart';
import '../../../domain/entities/profile_sup_entity.dart';
import '../../../domain/repositories/profile_sup_repository_interface.dart';
import '../../models/profile_sup_model.dart';
import '../datasources/profile_sup_datasource_interface.dart';

class ProfileSupRepository extends IProfileSupRepository {
  final IProfileSupDataSource _dataSource;

  ProfileSupRepository(this._dataSource);

  @override
  Future<Either<Failure, ProfileSupEntity>> get() async {
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
  Future<Either<Failure, ProfileSupModel>> postProfile(
      ProfileSupEntity request) async {
    try {
      var model = ProfileSupModel(
          id: request.id,
          image: request.image,
          name: request.name,
          email: request.email,
          phone: request.phone,
          street: request.street,
          district: request.district,
          placeNumber: request.placeNumber,
          complement: request.complement,
          postalCode: request.postalCode,
          city: request.city,
          state: request.state,
          totalReference: request.totalReference,
          totalAccept: request.totalAccept,
          totalReject: request.totalReject,
          selectedNeeds: request.selectedNeeds);

      final result = await _dataSource.postProfile(model);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NeedSupEntity>>> getNeeds() async {
    try {
      var result = <NeedSupEntity>[];
      var listNeed = await _dataSource.getNeeds();

      result = listNeed
          .map((e) => NeedSupEntity(
              id: e.id, description: e.description, active: e.active))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
