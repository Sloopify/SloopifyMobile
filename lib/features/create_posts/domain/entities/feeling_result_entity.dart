import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';

class FeelingResultEntity extends Equatable{
  final List<FeelingEntity> feelings;
  final PaginationData paginationData;
  const FeelingResultEntity({required this.paginationData,required this.feelings});
  @override
  // TODO: implement props
  List<Object?> get props => [feelings,paginationData];

}
