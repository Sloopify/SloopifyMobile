import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final int id;

  final String name;
  final String city;
  final String country;
  final String latitude;
  final String longitude;
  final String status;
  final String createdAt;
  final String updatedAt;

  const PlaceEntity({
    this.name = "",
    this.id = 0,
    this.updatedAt = "",
    this.createdAt = "",
    this.status = "",
    this.city = "",
    this.country = "",
    this.latitude = "",
    this.longitude = "",
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    city,
    country,
    latitude,
    longitude,
    status,
    createdAt,
    updatedAt,
  ];
}
