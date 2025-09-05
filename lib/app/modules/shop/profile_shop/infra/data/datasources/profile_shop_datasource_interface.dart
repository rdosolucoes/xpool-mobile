import '../../models/profile_shop_model.dart';

abstract class IProfileShopDataSource {
  Future<ProfileShopModel> get();

  //Future<String> uploadImage(dynamic filePath);

  Future<ProfileShopModel> postProfile(ProfileShopModel model);
}
