import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/profile_shop_model.dart';
import '../entities/profile_shop_entity.dart';
import '../repositories/profile_shop_repository_interface.dart';
import 'interface/post_profile_shop_interface.dart';

class PostProfileShop implements IPostProfileShop {
  final IProfileShopRepository _profileshopRepository;

  PostProfileShop(this._profileshopRepository);
  @override
  Future<Either<Failure, ProfileShopModel>> call(
      ProfileShopEntity request) async {
    if (request.validation.isNotEmpty) {
      return Left(DefaultFailure(message: request.validation));
    }

    try {
      return _profileshopRepository.postProfile(request);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar loja');
    }
  }
}
