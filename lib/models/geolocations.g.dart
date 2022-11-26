// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geolocations _$GeolocationsFromJson(Map<String, dynamic> json) => Geolocations(
      lang: json['lang'] as String? ?? '',
      lat: json['lat'] as String? ?? '',
    );

Map<String, dynamic> _$GeolocationsToJson(Geolocations instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lang': instance.lang,
    };
