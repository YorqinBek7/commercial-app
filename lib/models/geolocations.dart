import 'package:json_annotation/json_annotation.dart';

part 'geolocations.g.dart';

@JsonSerializable()
class Geolocations {
  @JsonKey(defaultValue: "", name: "lat")
  String lat;
  @JsonKey(defaultValue: "", name: "lang")
  String lang;

  Geolocations({required this.lang, required this.lat});

  factory Geolocations.fromJson(Map<String, dynamic> json) =>
      _$GeolocationsFromJson(json);

  Map<String, dynamic> toJson() => _$GeolocationsToJson(this);
}
