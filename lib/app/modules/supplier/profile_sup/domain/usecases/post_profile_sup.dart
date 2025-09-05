import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/profile_sup_model.dart';
import '../entities/profile_sup_entity.dart';
import '../repositories/profile_sup_repository_interface.dart';
import 'interface/post_profile_sup_interface.dart';

class PostProfileSup implements IPostProfileSup {
  final IProfileSupRepository _profilesupRepository;

  PostProfileSup(this._profilesupRepository);
  @override
  Future<Either<Failure, ProfileSupModel>> call(
      ProfileSupEntity request) async {
    if (request.validation.isNotEmpty) {
      return Left(DefaultFailure(message: request.validation));
    }

    try {
      return _profilesupRepository.postProfile(request);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar loja');
    }
  }
}
