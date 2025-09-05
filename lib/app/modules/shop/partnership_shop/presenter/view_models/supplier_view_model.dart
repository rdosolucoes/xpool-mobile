import 'package:flutter/foundation.dart';

import '../../domain/entities/supplier_entity.dart';

@immutable
class SupplierVM {
  final List<SupplierEntity> suppliers;
  final String filter;
  final int status;

  List<SupplierEntity> get supplierFiltered => suppliers
      .where((e) => e.name.toUpperCase().contains(filter.toUpperCase()))
      .toList();

  SupplierVM(
      {this.suppliers = const <SupplierEntity>[],
      this.filter = '',
      this.status = 0});

  SupplierVM copyWith({
    List<SupplierEntity>? suppliers,
    String? filter,
    int? status,
  }) {
    return SupplierVM(
      suppliers: suppliers ?? this.suppliers,
      filter: filter ?? this.filter,
      status: status ?? this.status,
    );
  }
}
