import 'package:sloopify_mobile/features/create_posts/data/models/place_model.dart';

import '../../../auth/data/models/pagination_data_model.dart';
import '../../domain/entities/user_place_result_entity.dart';

class UserPlacesResultModel extends UserPlaceResultEntity{
  UserPlacesResultModel({required super.paginationData, required super.places});
  factory UserPlacesResultModel.fromJson(Map<String, dynamic> json) {
    final placesList = json["user_places"] as List;


    return UserPlacesResultModel(
      paginationData: PaginationDataModel.fromJson(json["pagination"]),
      places: placesList.map((e) => PlaceModel.fromJson(e)).toList(),
    );
  }

}