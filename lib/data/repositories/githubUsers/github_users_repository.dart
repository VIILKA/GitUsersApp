import 'package:dio/dio.dart';
import 'package:g_hub/data/repositories/githubUsers/models/github_user.dart';

class GithubUsersRepository {
  GithubUsersRepository();
  final dio = Dio();

  Future<List<GithubUser>> fetchUsers({required int since}) async {
    final String apiUrl =
        'https://api.github.com/users?since=$since&per_page=30';
    final String token = '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'; //

    dio.options.headers['Authorization'] = 'token $token';

    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final data = response.data as List;
        final usersList = data
            .map((e) => GithubUser(
                name: e['login'], imageUrl: e['avatar_url'], id: e['id']))
            .toList();
        return usersList;
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String username) async {
    final String apiUrl = 'https://api.github.com/users/$username';
    final String token = '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';

    dio.options.headers['Authorization'] = 'token $token';
    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
