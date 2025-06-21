import 'package:equatable/equatable.dart';

import '../../../domain/entities/media_entity.dart';

class RotateMediaState extends Equatable {
  final MediaEntity mediaEntity;

  const RotateMediaState({required this.mediaEntity});

  RotateMediaState copyWith({MediaEntity? mediaEntity}) {
    return RotateMediaState(mediaEntity: mediaEntity ?? this.mediaEntity);
  }

  @override
  List<Object?> get props => [mediaEntity];
}