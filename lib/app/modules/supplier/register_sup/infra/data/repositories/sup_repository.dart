import 'package:dartz/dartz.dart';

import '../../../../../../../shared/auth/local_storage/interfaces/auth_repository_interface.dart';
import '../../../../../../../shared/auth/stores/auth_store.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/sup_entity.dart';
import '../../../domain/repositories/sup_repository_interface.dart';
import '../../models/sup_model.dart';
import '../datasources/sup_datasource_interface.dart';

class SupRepository implements ISupRepository {
  final ISupDatasource _dataSource;
  final AuthStore _authStore;
  final IAuthLocalStorage _localStorage;

  SupRepository(this._dataSource, this._authStore, this._localStorage);

  @override
  Future<Either<Failure, SupModel>> postSup(SupEntity request) async {
    try {
      var model = SupModel(
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
          needsId: request.needsId);

      final result = await _dataSource.postSup(model);

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

  @override
  Future<Either<Failure, bool>> sendCodeVerify(
      String email, String name, String phone) async {
    try {
      var result = await _dataSource.sendCodeVerify(email, name, phone);

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(RepositoryFailure(message: error.toString()));
    }
  }
}
