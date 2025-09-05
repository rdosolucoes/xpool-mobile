import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/profile_sup_model.dart';
import '../entities/need_sup_entity.dart';
import '../entities/profile_sup_entity.dart';

abstract class IProfileSupRepository {
  Future<Either<Failure, ProfileSupEntity>> get();
  Future<Either<Failure, ProfileSupModel>> postProfile(
      ProfileSupEntity request);

  Future<Either<Failure, List<NeedSupEntity>>> getNeeds();
}
