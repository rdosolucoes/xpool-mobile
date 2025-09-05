import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/profile_shop_datasource_interface.dart';
import '../../models/profile_shop_model.dart';

class ProfileShopDataSource extends IProfileShopDataSource {
  final DioForNative _client;

  ProfileShopDataSource(this._client);

  @override
  Future<ProfileShopModel> get() async {
    final url = Api.getProfile;

    final response = await _client.get(url);

    if (response.statusCode == 200 && response.data['success']) {
      var model = ProfileShopModel.fromMap(response.data['profile']);
      return model;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ProfileShopModel> postProfile(ProfileShopModel model) async {
    final url = Api.saveProfile;

    final response = await _client.post(url, data: model.toJson());

    if (response.statusCode == 200 && response.data['success']) {
      var model = ProfileShopModel.fromMapPost(response.data);
      return model;
    } else {
      if (response.statusCode != 200) {
        throw DatasourceError(message: "Sistema temporariamente indisponível.");
      } else {
        var msg = response.data['messageError'];
        throw DatasourceError(message: msg);
      }
    }
  }
}
