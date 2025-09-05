import 'package:flutter/foundation.dart';

import '../../domain/entities/myreference_sup_entity.dart';

@immutable
class MyReferenceVM {
  final List<MyReferenceSupEntity> references;
  final int status;

  MyReferenceVM(
      {this.references = const <MyReferenceSupEntity>[], this.status = 0});

  MyReferenceVM copyWith({
    List<MyReferenceSupEntity>? references,
    String? filter,
    int? status,
  }) {
    return MyReferenceVM(
      references: references ?? this.references,
      status: status ?? this.status,
    );
  }
}
