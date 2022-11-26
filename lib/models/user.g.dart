// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      v: json['__v'] as int? ?? 0,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      email: json['email'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      password: json['password'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'phone': instance.phone,
      '__v': instance.v,
    };
