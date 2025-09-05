import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/my_reference_sup_repository.dart';
import 'interfaces/set_done_deal_interface.dart';

class SetDoneDeal implements ISetDoneDeal {
  final IMyReferenceSupRepository _myReferenceRepository;

  SetDoneDeal(this._myReferenceRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int value, int referenceId) {
    var result = _myReferenceRepository.setDoneDeal(value, referenceId);

    return result;
  }
}
