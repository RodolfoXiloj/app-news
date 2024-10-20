import 'dart:convert';
import 'package:myapp/data/api/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<void> login(String email, String password) async {
    final response = await apiClient.post('/login', body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await apiClient.saveToken(token);
    } else {
      throw Exception('Error al iniciar sesión: ${response.body}');
    }
  }

  Future<void> register(String email, String password) async {
    final response = await apiClient.post('/register', body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      await apiClient.saveToken(token);
    } else {
      throw Exception('Error al registrarse: ${response.body}');
    }
  }

  Future<void> logout() async {
    await apiClient.deleteToken();
  }
}
