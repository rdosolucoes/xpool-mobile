import 'package:dartz/dartz.dart';

import '../../../helpers/errors.dart';
import '../entity/need_entity.dart';

abstract class INeedRepository {
  Future<Either<Failure, List<NeedEntity>>> get();
}
