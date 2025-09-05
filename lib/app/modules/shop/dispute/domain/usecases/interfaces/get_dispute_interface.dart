import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/dispute_entity.dart';

abstract class IGetDispute {
  Future<Either<Failure, DisputeEntity>> call(int supId, int referenceId);
}
