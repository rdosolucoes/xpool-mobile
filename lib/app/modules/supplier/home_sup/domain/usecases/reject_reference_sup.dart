import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/reference_sup_repository_interface.dart';
import 'interfaces/reject_reference_sup_interface.dart';

class RejectReferenceSup implements IRejectReferenceSup {
  final IReferenceSupRepository _referenceRepository;

  RejectReferenceSup(this._referenceRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int referenceId) {
    var result = _referenceRepository.reject(referenceId);

    return result;
  }
}
