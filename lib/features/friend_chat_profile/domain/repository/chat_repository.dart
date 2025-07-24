import '../entities/message.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages(String friendId);
  Future<void> sendMessage(String friendId, Message message);
  Future<void> blockUser(String userId);
  Future<void> reportUser(String userId);
  Future<void> starMessage(String messageId);
  Future<void> unstarMessage(String messageId);
  Future<void> pinMessage(String messageId);
  Future<void> unpinMessage(String messageId);
}
