// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountModelAdapter extends TypeAdapter<AccountModel> {
  @override
  final int typeId = 0;

  @override
  AccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountModel(
      email: fields[0] as String,
      password: fields[1] as String,
      name: fields[2] as String,
      surname: fields[3] as String,
      phone: fields[4] as String?,
      tcno: fields[5] as String?,
      addressFirst: fields[10] as String?,
      addressID: fields[6] as int?,
      adrressSecond: fields[11] as String?,
      city: fields[8] as String?,
      country: fields[7] as String?,
      district: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.surname)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.tcno)
      ..writeByte(6)
      ..write(obj.addressID)
      ..writeByte(7)
      ..write(obj.country)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.district)
      ..writeByte(10)
      ..write(obj.addressFirst)
      ..writeByte(11)
      ..write(obj.adrressSecond);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
