import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/category_intity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_intresets_entity.dart';

class InterestsDataResult extends Equatable {
  final List<UserInterestsEntity> interests;
  final PaginationData paginationData;

  InterestsDataResult({required this.paginationData, required this.interests});

  @override
  // TODO: implement props
  List<Object?> get props => [interests, paginationData];
}
