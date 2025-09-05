import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../entities/reference_entity.dart';

abstract class ICreateReference {
  Future<Either<Failure, ResultModel>> call(ReferenceEntity model);
}
