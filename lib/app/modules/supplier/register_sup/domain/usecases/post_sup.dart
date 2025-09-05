import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/sup_model.dart';
import '../entities/sup_entity.dart';
import '../repositories/sup_repository_interface.dart';
import 'interfaces/post_sup_interface.dart';

class PostSup implements IPostSup {
  final ISupRepository _shopRepository;

  PostSup(this._shopRepository);
  @override
  Future<Either<Failure, SupModel>> call(SupEntity request) async {
    if (request.validation.isNotEmpty) {
      return Left(DefaultFailure(message: request.validation));
    }

    try {
      return _shopRepository.postSup(request);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar loja');
    }
  }
}
