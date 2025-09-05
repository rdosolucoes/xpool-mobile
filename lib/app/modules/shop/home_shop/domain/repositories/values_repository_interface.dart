import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/values_header_entity.dart';

abstract class IValuesRepository {
  Future<Either<Failure, ValuesHeaderEntity>> get();
}
