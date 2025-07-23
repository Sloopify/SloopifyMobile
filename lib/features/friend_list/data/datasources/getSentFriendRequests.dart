import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getSentFriendRequests({
  required String token,
  int page = 1,
  int perPage = 3,
  String sortBy = 'name', // or "date_sent", "status"
  String sortOrder = 'asc', // or "desc"
  String status = 'pending', // or "declined", "cancelled", "all"
}) async {
  final url = Uri.parse(
    'https://dev.sloopify.com/api/v1/friends/get-sent-requests',
  );

  final response = await http.post(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'page': page.toString(),
      'per_page': perPage.toString(),
      'sort_by': sortBy,
      'sort_order': sortOrder,
      'status': status,
    }),
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    print("Sent friend requests: $json");
  } else {
    print("Failed to fetch sent requests. Status: ${response.statusCode}");
    print("Body: ${response.body}");
  }
}
