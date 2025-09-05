import 'package:flutter/foundation.dart';

import '../../../../../../shared/models/base_model.dart';

@immutable
class NeedEntity extends BaseModel {
  final int id;
  final String description;
  final String? image;

  NeedEntity(
      {required this.id,
      required this.description,
      this.image,
      String? messageError,
      bool? success})
      : super(messageError: messageError, success: success);

  NeedEntity copyWith(
      {required int id,
      required String description,
      String? image,
      String? messageError}) {
    return NeedEntity(
      id: id,
      image: image ?? this.image,
      description: description,
      messageError: messageError ?? this.messageError,
    );
  }
}
