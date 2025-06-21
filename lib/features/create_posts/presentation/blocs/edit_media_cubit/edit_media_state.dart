part of 'edit_media_cubit.dart';
class EditMediaState extends Equatable {
  final List<MediaEntity> mediaList;

  const EditMediaState({required this.mediaList});

  EditMediaState copyWith({List<MediaEntity>? mediaList}) {
    return EditMediaState(mediaList: mediaList ?? this.mediaList);
  }

  @override
  List<Object?> get props => [mediaList];
}
