import 'package:dartz/dartz.dart';

import '../../../../helpers/errors.dart';
import '../../../domain/entity/need_entity.dart';
import '../../../domain/repositories/need_repository_interface.dart';
import '../datasource/need_datasource_interface.dart';

class NeedRepository implements INeedRepository {
  final INeedDatasource _datasource;

  NeedRepository(this._datasource);

  @override
  Future<Either<Failure, List<NeedEntity>>> get() async {
    try {
      var result = <NeedEntity>[];
      var listNeed = await _datasource.get();

      result = listNeed
          .map((e) =>
              NeedEntity(id: e.id, description: e.description, image: e.image))
          .toList();

      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    } on Exception catch (error) {
      return Left(DefaultFailure(message: error.toString()));
    }
  }
}
