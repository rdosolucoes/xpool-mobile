import '../../domain/entities/shop_entity.dart';

class SupVM {
  final List<ShopEntity> shops;
  final String filter;
  final int status;

  List<String> filterneeds;

  List<ShopEntity> get shopFiltered => shops
      .where((e) => e.name.toUpperCase().contains(filter.toUpperCase()))
      .toList();

  SupVM(
      {this.shops = const <ShopEntity>[],
      this.filter = '',
      this.status = 0,
      this.filterneeds = const <String>[]});

  SupVM copyWith(
      {List<ShopEntity>? shops,
      String? filter,
      int? status,
      List<String>? filterneeds}) {
    return SupVM(
      shops: shops ?? this.shops,
      filter: filter ?? this.filter,
      status: status ?? this.status,
      filterneeds: filterneeds ?? this.filterneeds,
    );
  }
}
