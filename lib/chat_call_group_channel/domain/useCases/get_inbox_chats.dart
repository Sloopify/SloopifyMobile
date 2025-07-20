import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/chat.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/repositories/inbox_repository.dart';

class GetInboxChats {
  final InboxRepository repository;

  GetInboxChats(this.repository);

  Future<Either<Failure, List<Chat>>> call() {
    return repository.getInboxChats();
  }
}
