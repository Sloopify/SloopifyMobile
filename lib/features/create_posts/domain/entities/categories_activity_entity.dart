import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';

class ActivityCategoriesResult extends Equatable{
  final List<dynamic> categories;
  final PaginationData paginationData;
  const ActivityCategoriesResult({required this.paginationData,required this.categories});
  @override
  // TODO: implement props
  List<Object?> get props => [categories,paginationData];

}
