import '../../../../../../shared/models/dropdown_model.dart';
import '../../../../../../shared/needs/domain/entity/need_entity.dart';

class FilterPartnershipShopEntity {
  final List<NeedEntity> needs;
  List<NeedEntity> get listNeeds => needs.toList();
  List<int> filterneeds;
  DropdownModel? city;
  bool showPartners;

  FilterPartnershipShopEntity(
      {required this.needs,
      required this.filterneeds,
      this.city,
      this.showPartners = false});

  FilterPartnershipShopEntity copyWith(
      {List<NeedEntity>? needs,
      List<int>? filterneeds,
      DropdownModel? city,
      bool? showPartners}) {
    return FilterPartnershipShopEntity(
        needs: needs ?? this.needs,
        filterneeds: filterneeds ?? this.filterneeds,
        city: city ?? this.city,
        showPartners: showPartners ?? this.showPartners);
  }
}
