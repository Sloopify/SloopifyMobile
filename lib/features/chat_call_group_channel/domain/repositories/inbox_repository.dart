import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/chat.dart';

abstract class InboxRepository {
  Future<Either<Failure, List<Chat>>> getInboxChats();
}
