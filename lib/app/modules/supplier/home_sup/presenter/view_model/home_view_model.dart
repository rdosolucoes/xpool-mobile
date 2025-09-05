import '../../domain/entities/partner_sup_entity.dart';
import '../../domain/entities/reference_sup_entity.dart';

class HomeSupVM {
  final List<PartnerSupEntity> suppliers;
  final List<ReferenceSupEntity> references;
  List<PartnerSupEntity> get listSuppliers => suppliers.toList();

  HomeSupVM({
    this.suppliers = const <PartnerSupEntity>[],
    this.references = const <ReferenceSupEntity>[],
  });

  HomeSupVM copyWith(
      {List<PartnerSupEntity>? suppliers,
      List<ReferenceSupEntity>? references}) {
    return HomeSupVM(
        suppliers: suppliers ?? this.suppliers,
        references: references ?? this.references);
  }
}
