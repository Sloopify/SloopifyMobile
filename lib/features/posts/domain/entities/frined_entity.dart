import 'package:equatable/equatable.dart';

class FriendEntity extends Equatable{
  final String name;
  final int id;
  final bool isSent;
  final String profileImge;
  FriendEntity({required this.name,required this.id,required this.isSent,required this.profileImge});

  @override
  // TODO: implement props
  List<Object?> get props =>[name,id,isSent,profileImge];
}