import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';

class ActivityResultEntity extends Equatable{
  final List<ActivityEntity> activities;
  final PaginationData paginationData;
  ActivityResultEntity({required this.paginationData,required this.activities});
  @override
  // TODO: implement props
  List<Object?> get props => [activities,paginationData];

}
