import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../entities/profile_sup_entity.dart';
import '../repositories/profile_sup_repository_interface.dart';
import 'interface/get_profile_sup_interface.dart';

class GetProfileSup extends IGetProfileSup {
  final IProfileSupRepository _profileSupRepository;

  GetProfileSup(this._profileSupRepository);

  @override
  Future<Either<Failure, ProfileSupEntity>> call() async {
    var result = await _profileSupRepository.get();
    return result;
  }
}
