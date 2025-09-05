import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../../data/datasources/partner_sup_datasource_interface.dart';
import '../../models/partner_sup_model.dart';

class PartnerSupDataSource implements IPartnerSupDataSource {
  final DioForNative _client;

  PartnerSupDataSource(this._client);

  @override
  Future<List<PartnerSupModel>> get() async {
    final url = Api.searchPartnersSup;

    final response = await _client.get(url);
    var listPartnerSup = <PartnerSupModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("partners") &&
          response.data["partners"].isNotEmpty) {
        listPartnerSup = (response.data["partners"] as List)
            .map((e) => PartnerSupModel.fromMap(e))
            .toList();
      }

      return listPartnerSup;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
