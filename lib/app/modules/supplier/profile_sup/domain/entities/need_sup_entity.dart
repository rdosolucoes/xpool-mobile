import 'package:flutter/foundation.dart';

import '../../../../../../shared/models/base_model.dart';

@immutable
class NeedSupEntity extends BaseModel {
  final int id;
  final String description;
  final bool active;

  NeedSupEntity(
      {required this.id,
      required this.description,
      this.active = false,
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  NeedSupEntity copyWith(
      {required int id,
      required String description,
      bool? active,
      String? messageError}) {
    return NeedSupEntity(
      id: id,
      active: active ?? this.active,
      description: description,
      messageError: messageError ?? this.messageError,
    );
  }
}
