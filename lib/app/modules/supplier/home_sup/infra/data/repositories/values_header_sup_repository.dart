import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/values_header_sup_entity.dart';
import '../../../domain/repositories/values_header_sup_repository_interface.dart';
import '../datasources/values_header_sup_datasource_interface.dart';

class ValuesHeaderSupRepository implements IValuesHeaderSupRepository {
  // final IValuesDatasource _datasource;

  final IValuesHeaderSupDataSource _datasource;

  ValuesHeaderSupRepository(this._datasource);

  @override
  Future<Either<Failure, ValuesHeaderSupEntity>> get() async {
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
