import 'package:dartz/dartz.dart';

import '../../../../../../shared/helpers/errors.dart';
import '../../../../../../shared/models/dropdown_model.dart';
import '../../../../../../shared/repository/city_repository.dart';
import 'interfaces/get_cities_shop_interface.dart';

class GetCitiesShop implements IGetCitiesShop {
  final CityRepository _cityRepository;

  GetCitiesShop(this._cityRepository);
  @override
  Future<Either<Failure, List<DropdownModel>>> call() async {
    var result = await _cityRepository.getCitiesShop();

    return result;
  }
}
