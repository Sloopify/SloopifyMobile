import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';

class FriendsResultEntity extends Equatable{
  final List<UserEntity> friends;
  final PaginationData paginationData;
  FriendsResultEntity({required this.paginationData,required this.friends});
  @override
  // TODO: implement props
  List<Object?> get props => [friends,paginationData];

}
