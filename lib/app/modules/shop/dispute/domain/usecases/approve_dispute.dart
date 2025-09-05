import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/dispute_repository_interface.dart';
import 'interfaces/approve_dispute_interface.dart';

class ApproveDispute implements IApproveDispute {
  final IDisputeRepository _disputeRepository;

  ApproveDispute(this._disputeRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int disputeId) {
    return _disputeRepository.approve(disputeId);
  }
}
