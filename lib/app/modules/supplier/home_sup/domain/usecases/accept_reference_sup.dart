import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/reference_sup_repository_interface.dart';
import 'interfaces/accept_reference_sup_interface.dart';

class AcceptReferenceSup implements IAcceptReferenceSup {
  final IReferenceSupRepository _referenceRepository;

  AcceptReferenceSup(this._referenceRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int idReference) {
    var result = _referenceRepository.accept(idReference);

    return result;
  }
}
