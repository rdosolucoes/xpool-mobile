import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/needs/domain/entity/need_entity.dart';

abstract class IGetNeeds {
  Future<Either<Failure, List<NeedEntity>>> call();
}
