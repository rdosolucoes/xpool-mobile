import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/dropdown_model.dart';
import '../../../../../../shared/repository/city_repository.dart';
import 'interfaces/get_cities_interface.dart';

class GetCities implements IGetCities {
  final CityRepository _cityRepository;

  GetCities(this._cityRepository);
  @override
  Future<Either<Failure, List<DropdownModel>>> call(int stateId) async {
    var result = await _cityRepository.getCitiesUf(stateId);

    return result;
  }
}
