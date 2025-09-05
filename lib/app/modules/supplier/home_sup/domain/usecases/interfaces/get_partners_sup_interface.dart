import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../entities/partner_sup_entity.dart';

abstract class IGetPartnersSup {
  Future<Either<Failure, List<PartnerSupEntity>>> call();
}
