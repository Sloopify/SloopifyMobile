import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sloopify_mobile/features/chat_system/data/models/message_model.dart';

class ChatRemoteDataSource {
  final http.Client client;

  ChatRemoteDataSource(this.client);

  Future<List<MessageModel>> getMessages(String friendId) async {
    final response = await client.get(
      Uri.parse("https://yourapi.com/chat/messages/$friendId"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> decoded = json.decode(response.body);
      return decoded.map((e) => MessageModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load messages");
    }
  }
}
