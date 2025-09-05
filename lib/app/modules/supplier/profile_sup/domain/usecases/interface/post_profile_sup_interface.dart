import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../infra/models/profile_sup_model.dart';
import '../../entities/profile_sup_entity.dart';

abstract class IPostProfileSup {
  Future<Either<Failure, ProfileSupModel>> call(ProfileSupEntity request);
}
