// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_result_enitity.dart';
import 'package:sloopify_mobile/features/create_story/domain/repository/create_story_repository.dart';

import '../../../../core/errors/failures.dart';

class SearchStoryAudioUseCase {
  final CreateStoryRepo createStoryRepo;

  SearchStoryAudioUseCase({required this.createStoryRepo});

  Future<Either<Failure, AudioResultEntity>> call({required String name,required int page,required int perPage}) async {
    final res = await createStoryRepo.searchStoryAudios(search: name,perPage: perPage,page: page);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
