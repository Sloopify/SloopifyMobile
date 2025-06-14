import 'package:equatable/equatable.dart';

class CreatePlaceEntity extends Equatable {
  final int? id;
  final String? name;
  final String? city;
  final String? country;
  final String? latitude;
  final String? longitude;
  final String? status;

  const CreatePlaceEntity({
    this.city,
    this.status,
    this.longitude,
    this.latitude,
    this.country,
    this.id,
    this.name,
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
  ];

  toJson() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (city != null) "city": city,
      if (country != null) "country": country,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
      "status": "active",
    };
  }

  CreatePlaceEntity copWith({
    int? id,
    String? name,
    String? city,
    String? country,
    String? latitude,
    String? longitude,
    String? status,
  }) {
    return CreatePlaceEntity(
      latitude: latitude ?? this.latitude,
      country: country ?? this.country,
      status: status ?? this.status,
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      longitude: longitude ?? this.longitude,
    );
  }
}
