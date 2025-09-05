import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/result_model.dart';
import '../../../infra/models/dispute_sup_model.dart';

abstract class ICreateDispute {
  Future<Either<Failure, ResultModel>> call(DisputeModel model);
}
