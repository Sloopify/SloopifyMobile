import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/pagination_data.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_entity.dart';

class AudioResultEntity extends Equatable{
  final List<AudioEntity> audios;
  final PaginationData paginationData;
  const AudioResultEntity({required this.paginationData,required this.audios});
  @override
  // TODO: implement props
  List<Object?> get props => [audios,paginationData];

}
