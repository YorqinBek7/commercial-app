// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      city: json['city'] as String? ?? '',
      geolocations:
          Geolocations.fromJson(json['geolocation'] as Map<String, dynamic>),
      number: json['number'] as int? ?? 0,
      street: json['street'] as String? ?? '',
      zipcode: json['zipcode'] as String? ?? '',
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'geolocation': instance.geolocations,
      'city': instance.city,
      'street': instance.street,
      'number': instance.number,
      'zipcode': instance.zipcode,
    };
