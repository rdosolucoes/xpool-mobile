import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';

abstract class IBreakPartnerSupplier {
  Future<Either<Failure, ResultModel>> call(int userSupId);
}
