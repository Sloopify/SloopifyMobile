import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final String name;
  final String imageUrl;
  final bool isAdmin;

  const Member({
    required this.name,
    required this.imageUrl,
    this.isAdmin = false,
  });

  @override
  List<Object?> get props => [name, imageUrl, isAdmin];
}
