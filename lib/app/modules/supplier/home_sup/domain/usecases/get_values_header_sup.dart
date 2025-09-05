import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/values_header_sup_entity.dart';
import '../repositories/values_header_sup_repository_interface.dart';
import 'interfaces/get_values_headers_sup_interface.dart';

class GetValuesHeaderSup implements IGetValuesHeaderSup {
  final IValuesHeaderSupRepository _valuesRepository;

  GetValuesHeaderSup(this._valuesRepository);
  @override
  Future<Either<Failure, ValuesHeaderSupEntity>> call() async {
    var result = await _valuesRepository.get();

    return result;
  }
}
