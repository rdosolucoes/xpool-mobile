import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/profile_sup_entity.dart';

abstract class IGetProfileSup {
  Future<Either<Failure, ProfileSupEntity>> call();
}
