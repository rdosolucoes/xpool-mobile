import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/reference_sup_entity.dart';
import '../repositories/reference_sup_repository_interface.dart';
import 'interfaces/get_references_sup_interface.dart';

class GetReferencesSup implements IGetReferencesSup {
  final IReferenceSupRepository _referenceRepository;

  GetReferencesSup(this._referenceRepository);
  @override
  Future<Either<Failure, List<ReferenceSupEntity>>> call() async {
    var result = await _referenceRepository.get();

    return result;
  }
}
