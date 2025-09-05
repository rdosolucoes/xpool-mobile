import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/partner_sup_entity.dart';
import '../repositories/partner_sup_repository_interface.dart';
import 'interfaces/get_partners_sup_interface.dart';

class GetPartnersSup implements IGetPartnersSup {
  final IPartnerSupRepository _partnerRepository;

  GetPartnersSup(this._partnerRepository);
  @override
  Future<Either<Failure, List<PartnerSupEntity>>> call() async {
    var result = await _partnerRepository.get();

    return result;
  }
}
