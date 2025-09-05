import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/need_sup_entity.dart';
import '../repositories/profile_sup_repository_interface.dart';
import 'interface/get_needs_sup_interface.dart';

class GetNeedsSup implements IGetNeedsSup {
  final IProfileSupRepository _profileSupRepository;

  GetNeedsSup(this._profileSupRepository);
  @override
  Future<Either<Failure, List<NeedSupEntity>>> call() async {
    var result = await _profileSupRepository.getNeeds();

    return result;
  }
}
