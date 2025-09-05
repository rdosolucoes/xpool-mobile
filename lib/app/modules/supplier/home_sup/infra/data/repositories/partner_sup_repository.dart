import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../domain/entities/partner_sup_entity.dart';
import '../../../domain/repositories/partner_sup_repository_interface.dart';
import '../datasources/partner_sup_datasource_interface.dart';

class PartnerSupRepository implements IPartnerSupRepository {
  // final IPartnerSupDatasource _datasource;

  final IPartnerSupDataSource _datasource;

  PartnerSupRepository(this._datasource);

  @override
  Future<Either<Failure, List<PartnerSupEntity>>> get() async {
    try {
      var result = <PartnerSupEntity>[];
      var listPartnerSup = await _datasource.get();

      result = listPartnerSup
          .map((e) => PartnerSupEntity(
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
