import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';

class UserPlaceResultEntity extends Equatable{
  final List<PlaceEntity> places;
  final PaginationData paginationData;
  UserPlaceResultEntity({required this.paginationData,required this.places});
  @override
  // TODO: implement props
  List<Object?> get props => [places,paginationData];

}
