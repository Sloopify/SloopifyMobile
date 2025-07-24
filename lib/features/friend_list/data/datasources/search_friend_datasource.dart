// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<void> searchFriends({
//   required String query,
//   required String token,
//   int page = 1,
//   int perPage = 3,
// }) async {
//   final url = Uri.parse(
//     'https://dev.sloopify.com/api/v1/stories/search-friends',
//   );

//   final response = await http.post(
//     url,
//     headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       'search': query,
//       'page': page.toString(),
//       'per_page': perPage.toString(),
//     }),
//   );

//   if (response.statusCode == 200) {
//     final json = jsonDecode(response.body);
//     print("Search results: $json");
//   } else {
//     print("Failed to search friends. Status: ${response.statusCode}");
//     print("Body: ${response.body}");
//   }
// }
