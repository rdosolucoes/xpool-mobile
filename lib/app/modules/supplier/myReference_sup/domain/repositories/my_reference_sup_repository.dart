import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../entities/myreference_sup_entity.dart';

abstract class IMyReferenceSupRepository {
  Future<Either<Failure, List<MyReferenceSupEntity>>> get(
      int offset, int limit);
  Future<Either<Failure, ResultModel>> setDoneDeal(int value, int referenceId);
}
