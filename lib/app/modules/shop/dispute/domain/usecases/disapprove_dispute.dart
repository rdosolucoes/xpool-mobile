import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/dispute_repository_interface.dart';
import 'interfaces/disapprove_dispute_interface.dart';

class DisapproveDispute implements IDisapproveDispute {
  final IDisputeRepository _disputeRepository;

  DisapproveDispute(this._disputeRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int disputeId, String message) {
    return _disputeRepository.disapprove(disputeId, message);
  }
}
