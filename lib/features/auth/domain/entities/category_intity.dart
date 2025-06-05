import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_intresets_entity.dart';

class CategoryInterestsEntity extends Equatable{
  final String categoryName;
  final List<UserInterestsEntity> interests;
  const CategoryInterestsEntity({required this.categoryName,required this.interests});
  @override
  // TODO: implement props
  List<Object?> get props =>[ categoryName,interests];

}