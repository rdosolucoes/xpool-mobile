import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/myreference_sup_entity.dart';

abstract class IGetMyReferences {
  Future<Either<Failure, List<MyReferenceSupEntity>>> call(
      int offset, int limit);
}
