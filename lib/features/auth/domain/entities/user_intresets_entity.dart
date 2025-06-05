import 'package:equatable/equatable.dart';

class UserInterestsEntity extends Equatable{
  final int id;
  final String name;
  final String image;
  final String status;
  const UserInterestsEntity({required this.name,required this.status,required this.id,required this.image});
  @override
  // TODO: implement props
  List<Object?> get props => [id,name,image,status];

}