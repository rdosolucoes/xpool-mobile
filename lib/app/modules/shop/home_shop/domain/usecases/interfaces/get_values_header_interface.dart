import 'package:dartz/dartz.dart';

import '../../../../../../../../shared/helpers/errors.dart';
import '../../entities/values_header_entity.dart';

abstract class IGetValuesHeader {
  Future<Either<Failure, ValuesHeaderEntity>> call();
}
