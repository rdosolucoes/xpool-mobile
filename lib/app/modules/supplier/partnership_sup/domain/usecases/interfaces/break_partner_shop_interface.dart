import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';

abstract class IBreakPartnerShop {
  Future<Either<Failure, ResultModel>> call(int userShopId);
}
