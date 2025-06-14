import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    super.city,
    super.country,
    super.createdAt,
    super.id,
    super.latitude,
    super.longitude,
    super.name,
    super.status,
    super.updatedAt,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json["name"] ?? "",
      id: json["id"] ?? "",
      status: json["status"] ?? "",
      updatedAt: json["updated_at"],
      createdAt: json["updated_at"],
      country: json["country"] ?? "",
      city: json["city"] ?? "",
      latitude: json["latitude"]??"",
      longitude: json["longitude"] ?? "",
    );
  }
}
