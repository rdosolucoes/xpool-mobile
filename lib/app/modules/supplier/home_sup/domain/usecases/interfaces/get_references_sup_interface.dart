import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/reference_sup_entity.dart';

abstract class IGetReferencesSup {
  Future<Either<Failure, List<ReferenceSupEntity>>> call();
}
