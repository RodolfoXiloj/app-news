import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class ApiClient {
  final String baseUrl;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  ApiClient(this.baseUrl);

  // Obtiene el JWT almacenado en el dispositivo
  Future<String?> _getToken() async {
    return dotenv.env['NEWS_API_KEY'] ??
        await _secureStorage.read(key: 'jwt_token');
  }

  // Método para hacer peticiones POST con el JWT
  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final token = await _getToken();
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    };
    return await http.post(uri,
        headers: requestHeaders, body: jsonEncode(body));
  }

  // Método para hacer peticiones GET con el JWT
  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final token = await _getToken();
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      ...?headers,
    };
    return await http.get(uri, headers: requestHeaders);
  }

  // Método para guardar el JWT después del inicio de sesión
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'jwt_token', value: token);
  }

  // Método para eliminar el JWT al cerrar sesión
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'jwt_token');
  }
}
