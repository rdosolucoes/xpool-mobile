import 'package:dartz/dartz.dart';

import '../../../../../../../../shared/helpers/errors.dart';
import '../../entities/values_header_sup_entity.dart';

abstract class IGetValuesHeaderSup {
  Future<Either<Failure, ValuesHeaderSupEntity>> call();
}
