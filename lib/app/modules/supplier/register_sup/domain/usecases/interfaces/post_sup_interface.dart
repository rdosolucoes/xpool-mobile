import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../infra/models/sup_model.dart';
import '../../entities/sup_entity.dart';

abstract class IPostSup {
  Future<Either<Failure, SupModel>> call(SupEntity request);
}
