import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../entities/reference_entity.dart';
import '../repositories/reference_repository_interface.dart';
import 'interfaces/create_reference_interface.dart';

class CreateReference implements ICreateReference {
  final IReferenceRepository _referenceRepository;

  CreateReference(this._referenceRepository);

  @override
  Future<Either<Failure, ResultModel>> call(ReferenceEntity model) {
    var result = _referenceRepository.create(model);

    return result;
  }
}
