import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../infra/models/shop_model.dart';
import '../entities/shop_entity.dart';
import '../repositories/shop_repository_interface.dart';
import 'interfaces/post_shop_interface.dart';

class PostShop implements IPostShop {
  final IShopRepository _shopRepository;

  PostShop(this._shopRepository);
  @override
  Future<Either<Failure, ShopModel>> call(ShopEntity request) async {
    if (request.validation.isNotEmpty) {
      return Left(DefaultFailure(message: request.validation));
    }

    try {
      return _shopRepository.postShop(request);
    } on Exception {
      throw DefaultFailure(message: 'Erro ao tentar salvar loja');
    }
  }
}
