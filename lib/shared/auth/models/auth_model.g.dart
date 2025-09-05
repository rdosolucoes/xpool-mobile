// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthModelAdapter extends TypeAdapter<AuthModel> {
  @override
  final int typeId = 0;

  @override
  AuthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthModel(
      accessToken: fields[0] as String,
      refreshToken: fields[1] as String,
      uid: fields[2] as String,
      expireDate: fields[3] as String?,
      userName: fields[4] as String,
      password: fields[5] as String,
      name: fields[6] as String?,
      confirmPassword: fields[7] as String,
      messageError: fields[8] as String?,
      islogged: fields[9] as bool,
      isSignMode: fields[10] as bool,
      typeUser: fields[11] as int,
      image: fields[12] as String?,
      playerId: fields[13] as String?,
      emailValidate: fields[14] as bool?,
      isEmployee: fields[15] as bool?,
      cityId: fields[16] as int?,
      pendingDelete: fields[17] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.refreshToken)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.expireDate)
      ..writeByte(4)
      ..write(obj.userName)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.confirmPassword)
      ..writeByte(8)
      ..write(obj.messageError)
      ..writeByte(9)
      ..write(obj.islogged)
      ..writeByte(10)
      ..write(obj.isSignMode)
      ..writeByte(11)
      ..write(obj.typeUser)
      ..writeByte(12)
      ..write(obj.image)
      ..writeByte(13)
      ..write(obj.playerId)
      ..writeByte(14)
      ..write(obj.emailValidate)
      ..writeByte(15)
      ..write(obj.isEmployee)
      ..writeByte(16)
      ..write(obj.cityId)
      ..writeByte(17)
      ..write(obj.pendingDelete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
