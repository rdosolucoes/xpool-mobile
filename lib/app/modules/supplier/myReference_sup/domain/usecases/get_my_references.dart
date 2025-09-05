import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/myreference_sup_entity.dart';
import '../repositories/my_reference_sup_repository.dart';
import 'interfaces/get_my_references_interface.dart';

class GetMyReferences implements IGetMyReferences {
  final IMyReferenceSupRepository _myReferenceRepository;

  GetMyReferences(this._myReferenceRepository);
  @override
  Future<Either<Failure, List<MyReferenceSupEntity>>> call(
      int offset, int limit) async {
    var result = await _myReferenceRepository.get(offset, limit);

    return result;
  }
}
