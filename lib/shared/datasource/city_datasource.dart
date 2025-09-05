import 'package:dio/native_imp.dart';

import '../../../../../../../shared/helpers/api.dart';
import '../../../../../../../shared/helpers/errors.dart';
import '../models/dropdown_model.dart';

class CityDataSource {
  final DioForNative _client;

  CityDataSource(this._client);

  Future<List<DropdownModel>> getCitiesUf(int stateId) async {
    final url = Api.loadCitiesByUf;

    final response = await _client.get(url, queryParameters: {
      "stateId": stateId,
    });

    var listCities = <DropdownModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("cities") &&
          response.data["cities"].isNotEmpty) {
        listCities = (response.data["cities"] as List)
            .map((e) => DropdownModel.fromMap(e))
            .toList();
      }

      return listCities;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  Future<List<DropdownModel>> getCitiesSup() async {
    final url = Api.loadCitiesSup;

    final response = await _client.get(url);

    var listCities = <DropdownModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("cities") &&
          response.data["cities"].isNotEmpty) {
        listCities = (response.data["cities"] as List)
            .map((e) => DropdownModel.fromMap(e))
            .toList();
      }

      return listCities;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }

  Future<List<DropdownModel>> getCitiesShop() async {
    final url = Api.loadCitiesShop;

    final response = await _client.get(url);

    var listCities = <DropdownModel>[];

    if (response.statusCode == 200 && response.data['success']) {
      if (response.data.containsKey("cities") &&
          response.data["cities"].isNotEmpty) {
        listCities = (response.data["cities"] as List)
            .map((e) => DropdownModel.fromMap(e))
            .toList();
      }

      return listCities;
    } else {
      var msg = response.data['messageError'];
      throw DatasourceError(message: msg);
    }
  }
}
