import 'dart:convert';

class ResultModel {
  final bool success;
  final String? message;
  ResultModel({
    required this.success,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      success: map['success'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) =>
      ResultModel.fromMap(json.decode(source));
}
