import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/needs/domain/entity/need_entity.dart';
import '../../../../../../shared/needs/domain/repositories/need_repository_interface.dart';
import 'interfaces/get_needs_interface.dart';

class GetNeeds implements IGetNeeds {
  final INeedRepository _needRepository;

  GetNeeds(this._needRepository);
  @override
  Future<Either<Failure, List<NeedEntity>>> call() async {
    var result = await _needRepository.get();

    return result;
  }
}
