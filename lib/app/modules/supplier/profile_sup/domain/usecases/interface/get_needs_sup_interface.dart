import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/need_sup_entity.dart';

abstract class IGetNeedsSup {
  Future<Either<Failure, List<NeedSupEntity>>> call();
}
