import '../../domain/entities/supplier_reference_entity.dart';

class SupplierVM {
  final List<SupplierReferenceEntity> suppliers;
  final String filter;
  final int status;
  final String name;
  final String phone;
  final String description;

  List<SupplierReferenceEntity> get supplierFiltered => suppliers
      .where((e) => e.name.toUpperCase().contains(filter.toUpperCase()))
      .toList();

  SupplierVM(
      {this.suppliers = const <SupplierReferenceEntity>[],
      this.filter = '',
      this.status = 0,
      this.name = "",
      this.phone = "",
      this.description = ""});

  SupplierVM copyWith(
      {List<SupplierReferenceEntity>? suppliers,
      List<int>? checkedSuppliers,
      String? filter,
      int? status,
      String? name,
      String? phone,
      String? description}) {
    return SupplierVM(
      suppliers: suppliers ?? this.suppliers,
      filter: filter ?? this.filter,
      status: status ?? this.status,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      description: description ?? this.description,
    );
  }
}
