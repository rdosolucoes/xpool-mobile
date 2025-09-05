import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/result_model.dart';
import '../repositories/partnership_repository_interface.dart';
import 'interfaces/break_partner_supplier_interface.dart';

class BreakPartnerSupplier implements IBreakPartnerSupplier {
  final IPartnershipRepository _partnershipRepository;

  BreakPartnerSupplier(this._partnershipRepository);

  @override
  Future<Either<Failure, ResultModel>> call(int userSupId) {
    var result = _partnershipRepository.breakPartner(userSupId);

    return result;
  }
}
