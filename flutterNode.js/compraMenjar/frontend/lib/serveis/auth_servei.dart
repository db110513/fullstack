import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServei {

  static const String baseUrl = 'http://10.0.2.2:3000/api/usuaris';

  static Future<bool> login(String usuari, String contrassenya) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuari': usuari, 'contrassenya': contrassenya}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Resposta del servidor: $data');
      return true;
    }

    else {
      print('Error: ${response.body}');
      return false;
    }
  }
}
