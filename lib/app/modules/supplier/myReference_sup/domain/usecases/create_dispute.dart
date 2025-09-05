import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../../../../../../shared/repository/dispute_repository.dart';
import '../../infra/models/dispute_sup_model.dart';
import 'interfaces/create_dispute_interface.dart';

class CreateDispute implements ICreateDispute {
  final DisputeRepository _disputeRepository;

  CreateDispute(this._disputeRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(DisputeModel model) {
    var result = _disputeRepository.create(model);

    return result;
  }
}
