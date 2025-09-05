import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/dropdown_model.dart';

abstract class IGetCities {
  Future<Either<Failure, List<DropdownModel>>> call(int stateId);
}
