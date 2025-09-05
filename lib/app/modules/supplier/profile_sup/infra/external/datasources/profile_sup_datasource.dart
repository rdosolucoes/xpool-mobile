import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/profile_sup_datasource_interface.dart';
import '../../models/need_sup_model.dart';
import '../../models/profile_sup_model.dart';

class ProfileSupDataSource extends IProfileSupDataSource {
  final DioForNative _client;

  ProfileSupDataSource(this._client);

  @override
  Future<ProfileSupModel> get() async {
    final url = Api.getProfileSup;

    final response = await _client.get(url);

    if (response.statusCode == 200 && response.data['success']) {
      var model = ProfileSupModel.fromMap(response.data['profile']);
      return model;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  @override
  Future<ProfileSupModel> postProfile(ProfileSupModel model) async {
    final url = Api.saveProfileSup;

    final response = await _client.post(url, data: model.toJson());

    if (response.statusCode == 200 && response.data['success']) {
      var model = ProfileSupModel.fromMapPost(response.data);
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

  @override
  Future<List<NeedSupModel>> getNeeds() async {
    final url = Api.loadNeedSupProfile;

    final response = await _client.get(url);
    var listNeeds = <NeedSupModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("needs") &&
          response.data["needs"].isNotEmpty) {
        listNeeds = (response.data["needs"] as List)
            .map((e) => NeedSupModel.fromMap(e))
            .toList();
      }

      return listNeeds;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
