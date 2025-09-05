import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/sup_model.dart';
import '../entities/sup_entity.dart';

abstract class ISupRepository {
  Future<Either<Failure, SupModel>> postSup(SupEntity request);
  Future<Either<Failure, bool>> sendCodeVerify(
      String email, String name, String phone);
}
