import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/onboarding_data_info.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';

class LoginEntity extends Equatable{
  final UserEntity userEntity;
  final OnBoardingDataInfo onBoardingDataInfo;

  LoginEntity({required this.onBoardingDataInfo,required this.userEntity});
  @override
  // TODO: implement props
  List<Object?> get props =>[userEntity,onBoardingDataInfo];

}