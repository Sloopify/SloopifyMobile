import 'package:equatable/equatable.dart';

class FeelingEntity extends Equatable {
  final int id;
  final String name;
  final String mobileIcon;
  final String status;
  final String createdAt;
  final String updatedAt;

  const FeelingEntity({
    required this.name,
    required this.id,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.mobileIcon,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,mobileIcon,status,createdAt,updatedAt];
}
