import 'package:http/http.dart' as http;
import 'dart:convert';

class ServeisUsuari {

  final String url = 'http://10.0.2.2:3000/usuaris';

  Future<Map<String, dynamic>> login(String nomUsuari, String contrassenya) async {
    final response = await http.post(
      Uri.parse('$url/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomUsuari': nomUsuari,
        'contrassenya': contrassenya,
      }),
    );

    if (response.statusCode == 200) return jsonDecode(response.body);
    else throw Exception('Error en iniciar sessió');

  }

  Future<Map<String, dynamic>> registre(String nomUsuari, String contrassenya) async {

    final response = await http.post(
      Uri.parse('$url/registre'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomUsuari': nomUsuari,
        'contrassenya': contrassenya,
      }),
    );

    if (response.statusCode == 201) return jsonDecode(response.body);
    else throw Exception('Error en registrar l\'usuari');

  }

}
