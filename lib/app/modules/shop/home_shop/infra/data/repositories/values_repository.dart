import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/values_header_entity.dart';
import '../../../domain/repositories/values_repository_interface.dart';
import '../datasources/values_datasource_interface.dart';

class ValuesRepository implements IValuesRepository {
  // final IValuesDatasource _datasource;

  final IValuesDataSource _datasource;

  ValuesRepository(this._datasource);

  @override
  Future<Either<Failure, ValuesHeaderEntity>> get() async {
    try {
      var result = await _datasource.get();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
