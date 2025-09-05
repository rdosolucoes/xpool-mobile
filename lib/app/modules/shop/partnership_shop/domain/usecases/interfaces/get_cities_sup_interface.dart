import 'package:dartz/dartz.dart';

import '../../../../../../../shared/helpers/errors.dart';
import '../../../../../../../shared/models/dropdown_model.dart';

abstract class IGetCitiesSup {
  Future<Either<Failure, List<DropdownModel>>> call();
}
