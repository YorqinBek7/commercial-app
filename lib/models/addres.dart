import 'package:commercial_app/models/geolocations.dart';
import 'package:json_annotation/json_annotation.dart';
part 'addres.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(name: "geolocation")
  Geolocations geolocations;
  @JsonKey(defaultValue: "", name: "city")
  String city;
  @JsonKey(defaultValue: "", name: "street")
  String street;
  @JsonKey(defaultValue: 0, name: "number")
  int number;
  @JsonKey(defaultValue: "", name: "zipcode")
  String zipcode;

  Address({
    required this.city,
    required this.geolocations,
    required this.number,
    required this.street,
    required this.zipcode,
  });


  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
