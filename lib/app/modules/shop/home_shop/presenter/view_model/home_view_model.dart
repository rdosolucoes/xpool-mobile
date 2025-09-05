import '../../../partnership_shop/domain/entities/supplier_entity.dart';
import '../../domain/entities/reference_shop_entity.dart';

class HomeVM {
  final List<SupplierEntity> suppliers;
  final List<ReferenceShopEntity> references;
  final List<ReferenceShopEntity> referencesFiltered;
  final int filterType;
  final int totalActive;
  final int totalComplete;
  final int totalExpired;

  HomeVM(
      {this.suppliers = const <SupplierEntity>[],
      this.references = const <ReferenceShopEntity>[],
      this.referencesFiltered = const <ReferenceShopEntity>[],
      this.filterType = 0,
      this.totalActive = 0,
      this.totalComplete = 0,
      this.totalExpired = 0});

  HomeVM copyWith(
      {List<SupplierEntity>? suppliers,
      List<ReferenceShopEntity>? references,
      List<ReferenceShopEntity>? referencesFiltered,
      int? filterType,
      int? totalActive,
      int? totalComplete,
      int? totalExpired}) {
    return HomeVM(
        suppliers: suppliers ?? this.suppliers,
        references: references ?? this.references,
        referencesFiltered: referencesFiltered ?? this.referencesFiltered,
        filterType: filterType ?? this.filterType,
        totalActive: totalActive ?? this.totalActive,
        totalComplete: totalComplete ?? this.totalComplete,
        totalExpired: totalExpired ?? this.totalExpired);
  }
}
