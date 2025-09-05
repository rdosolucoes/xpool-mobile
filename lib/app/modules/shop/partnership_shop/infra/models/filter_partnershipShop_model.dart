import 'dart:convert';

import '../../../../../../shared/models/dropdown_model.dart';
import '../../../../../../shared/needs/domain/entity/need_entity.dart';
import '../../domain/entities/filter_partnershipShop_entity.dart';

class FilterPartnershipShopModel extends FilterPartnershipShopEntity {
  FilterPartnershipShopModel(
      {List<int> filterneeds = const <int>[],
      List<NeedEntity> needs = const <NeedEntity>[],
      DropdownModel? city,
      bool showPartners = false})
      : super(
            filterneeds: filterneeds,
            needs: needs,
            city: city,
            showPartners: showPartners);

  factory FilterPartnershipShopModel.fromMap(Map<String, dynamic>? json) {
    if (json == null) return FilterPartnershipShopModel();

    return FilterPartnershipShopModel(
      filterneeds: json['filterneeds'] ?? '',
      needs: json['needs'] ?? '',
      city: json['city'] ?? '',
      showPartners: json['showPartners'] ?? '',
    );
  }

  factory FilterPartnershipShopModel.fromJson(String source) =>
      FilterPartnershipShopModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {'needs': filterneeds};
  }

  String toJson() => json.encode(toMap());
}
