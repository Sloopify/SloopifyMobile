import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
  final int id;
  final String name;
  final String mobileIcon;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String category;

  const ActivityEntity({
    required this.updatedAt,
    required this.createdAt,
    required this.status,
    required this.mobileIcon,
    required this.id,
    required this.name,
    required this.category,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,mobileIcon,status,createdAt,updatedAt,category];
}
