import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/dropdown_model.dart';
import '../../../../../../shared/repository/city_repository.dart';
import 'interfaces/get_cities_sup_interface.dart';

class GetCitiesSup implements IGetCitiesSup {
  final CityRepository _cityRepository;

  GetCitiesSup(this._cityRepository);
  @override
  Future<Either<Failure, List<DropdownModel>>> call() async {
    var result = await _cityRepository.getCitiesSup();

    return result;
  }
}
