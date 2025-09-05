import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/values_header_entity.dart';
import '../repositories/values_repository_interface.dart';
import 'interfaces/get_values_header_interface.dart';

class GetValuesHeader implements IGetValuesHeader {
  final IValuesRepository _valuesRepository;

  GetValuesHeader(this._valuesRepository);
  @override
  Future<Either<Failure, ValuesHeaderEntity>> call() async {
    var result = await _valuesRepository.get();

    return result;
  }
}
