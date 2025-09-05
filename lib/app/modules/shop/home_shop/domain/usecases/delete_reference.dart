import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/reference_shop_repository_interface.dart';
import 'interfaces/delete_reference_interface.dart';

class DeleteReference implements IDeleteReference {
  final IReferenceShopRepository _referenceRepository;

  DeleteReference(this._referenceRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int referenceId) {
    var result = _referenceRepository.delete(referenceId);

    return result;
  }
}
