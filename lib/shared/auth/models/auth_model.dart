import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 0)
class AuthModel extends HiveObject {
  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String refreshToken;
  @HiveField(2)
  final String uid;
  @HiveField(3)
  final String? expireDate;
  @HiveField(4)
  final String userName;
  @HiveField(5)
  final String password;
  @HiveField(6)
  final String? name;
  @HiveField(7)
  final String confirmPassword;
  @HiveField(8)
  final String? messageError;
  @HiveField(9)
  final bool islogged;
  @HiveField(10)
  final bool isSignMode;
  @HiveField(11)
  final int typeUser;
  @HiveField(12)
  final String? image;
  @HiveField(13)
  final String? playerId;
  @HiveField(14)
  final bool? emailValidate;
  @HiveField(15)
  final bool? isEmployee;
  @HiveField(16)
  final int? cityId;
  @HiveField(17)
  final bool? pendingDelete;

  AuthModel(
      {this.accessToken = '',
      this.refreshToken = '',
      this.uid = '',
      this.expireDate = '',
      this.userName = '',
      this.password = '',
      this.name,
      this.confirmPassword = '',
      this.messageError,
      this.islogged = false,
      this.isSignMode = false,
      this.typeUser = 0,
      this.image,
      this.playerId = '',
      this.emailValidate = false,
      this.isEmployee = false,
      this.cityId = 0,
      this.pendingDelete = false});

  AuthModel copyWith(
      {String? accessToken,
      String? refreshToken,
      String? uid,
      String? expireDate,
      String? userName,
      String? password,
      String? name,
      String? confirmPassword,
      String? messageError,
      bool? islogged,
      bool? isSignMode,
      int? typeUser,
      String? image,
      String? playerId,
      bool? emailValidate,
      bool? isEmployee,
      int? cityId,
      bool? pendingDelete}) {
    return AuthModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        uid: uid ?? this.uid,
        expireDate: expireDate ?? this.expireDate,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        name: name ?? this.name,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        messageError: messageError ?? this.messageError,
        islogged: islogged ?? this.islogged,
        isSignMode: isSignMode ?? this.isSignMode,
        typeUser: typeUser ?? this.typeUser,
        image: image ?? this.image,
        playerId: playerId ?? this.playerId,
        emailValidate: emailValidate ?? this.emailValidate,
        isEmployee: isEmployee ?? this.isEmployee,
        cityId: cityId ?? this.cityId,
        pendingDelete: pendingDelete ?? this.pendingDelete);
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'uid': uid,
      'expireDate': expireDate,
      'typeUser': typeUser,
      'name': name,
      'image': image,
      'playerId': playerId,
      'emailValidate': emailValidate,
      'isEmployee': isEmployee,
      'cityId': cityId
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
        accessToken: map['accessToken'],
        refreshToken: map['refreshToken'],
        uid: map['uid'],
        expireDate: map['expireDate'],
        typeUser: map['typeUser'],
        name: map['name'],
        image: map['image'],
        emailValidate: map['emailValidate'],
        isEmployee: map['isEmployee'],
        cityId: map['cityId']);
  }

  factory AuthModel.fromHeader(Headers headers) {
    var emailValidate = false;
    var isEmployee = false;
    var cityId = 0;

    if (headers['emailValidate'] != null) {
      emailValidate = headers['emailValidate']![0] == "True";
    }

    if (headers['isEmployee'] != null) {
      isEmployee = headers['isEmployee']![0] == "True";
    }

    if (headers['cityId'] != null) {
      cityId = int.parse(headers['cityId']![0]);
    }

    return AuthModel(
        accessToken: headers['accessToken']![0],
        refreshToken: headers['refreshToken']![0],
        uid: headers['uid']![0],
        expireDate: headers['expireDate']![0],
        typeUser: int.parse(headers['typeUser']![0]),
        name: headers['name'] == null ? "" : headers['name']![0],
        image: headers['image'] == null ? "" : headers['image']![0],
        emailValidate: emailValidate,
        isEmployee: isEmployee,
        cityId: cityId);
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthModel(accessToken: $accessToken, refreshToken: $refreshToken, expireDate: $expireDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.uid == uid &&
        other.expireDate == expireDate &&
        other.userName == userName &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.isSignMode == isSignMode &&
        other.typeUser == typeUser &&
        other.name == name &&
        other.playerId == playerId &&
        other.image == image &&
        other.emailValidate == emailValidate &&
        other.isEmployee == isEmployee &&
        other.cityId == cityId &&
        other.pendingDelete == pendingDelete;
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^ refreshToken.hashCode ^ uid.hashCode;
}
