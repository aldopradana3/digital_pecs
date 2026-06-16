import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/app_data.dart';

class ApiService {
  static const String baseUrl = 'https://digitalpecs.site/api';

  /// HEADER UNTUK API YANG MEMBUTUHKAN TOKEN
  static Map<String, String> get headers {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${User.token}',
    };
  }

  /// LOGIN
  static String lastMessage = '';
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      );

      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          User.token = data['token'] ?? '';

          final user = data['user'] ?? {};

          User.id = user['id'] ?? 0;

          User.username = user['username'] ?? '';

          User.email = user['email'] ?? '';

          User.role = user['role'] ?? '';

          User.orangtuaId = user['orangtua_id']?.toString() ?? '';

          User.nohp = user['nohp'] ?? '';

          User.alamat = user['alamat'] ?? '';

          User.tglLahir = user['tgl_lahir'] ?? '';

          User.status = user['status'] ?? '';

          User.isLoggedIn = true;

          return true;
        }
      } else {
        final data = jsonDecode(response.body);

        lastMessage = data['message'] ?? '';
      }

      return false;
    } catch (e) {
      print('LOGIN ERROR');
      print(e);

      return false;
    }
  }

  /// PROFILE
  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: headers,
      );

      print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('PROFILE ERROR');
      print(e);

      return null;
    }
  }
}
