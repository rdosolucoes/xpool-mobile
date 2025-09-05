import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_notification_model.dart';
import '../repositories/partnership_repository_interface.dart';
import 'interfaces/create_invite_supplier_interface.dart';

class CreateInviteSupplier implements ICreateInviteSupplier {
  final IPartnershipRepository _partnershipRepository;

  CreateInviteSupplier(this._partnershipRepository);

  @override
  Future<Either<Failure, ResultNotificationModel>> call(int userSupId) {
    var result = _partnershipRepository.post(userSupId);

    return result;
  }
}
