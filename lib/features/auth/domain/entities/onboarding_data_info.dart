import 'package:equatable/equatable.dart';

class OnBoardingDataInfo extends Equatable {
  final bool interests;
  final bool gender;
  final bool birthDay;
  final bool image;

  OnBoardingDataInfo({
    required this.image,
    required this.gender,
    required this.birthDay,
    required this.interests,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [interests, gender, birthDay, image];
}
