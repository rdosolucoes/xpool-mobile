import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/partnership_repository_interface.dart';
import 'interfaces/cancel_invite_supplier_interface.dart';

class CancelInviteSupplier implements ICancelInviteSupplier {
  final IPartnershipRepository _partnershipRepository;

  CancelInviteSupplier(this._partnershipRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int userSupId) {
    var result = _partnershipRepository.delete(userSupId);

    return result;
  }
}
