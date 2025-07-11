import 'package:sloopify_mobile/features/create_posts/data/models/feeling_model.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_result_entity.dart';
import 'package:sloopify_mobile/features/create_story/data/models/audio_model.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_result_enitity.dart';

import '../../../auth/data/models/pagination_data_model.dart';

class AudioResultModel extends AudioResultEntity{
  AudioResultModel({required super.paginationData, required super.audios});
  factory AudioResultModel.fromJson(Map<String, dynamic> json) {
    final audios = json["audio"] as List;

    return AudioResultModel(
      paginationData: PaginationDataModel.fromJson(json["pagination"]),
      audios: audios.map((e) => AudioModel.fromJson(e)).toList(),
    );
  }

}