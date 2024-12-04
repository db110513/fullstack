import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class ServeisUsuari {

  final String url = 'http://10.0.2.2:3000/usuaris';

  Future<Map<String, dynamic>> login(String nomUsuari, String contrassenya, BuildContext context) async {
    final response = await http.post(
      Uri.parse('$url/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomUsuari': nomUsuari,
        'contrassenya': contrassenya,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else if (response.statusCode == 404) {
      final responseData = jsonDecode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'] ?? 'Error desconegut'))
      );

      throw Exception(responseData['message']);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en iniciar sessió'))
      );
      throw Exception('Error en iniciar sessió');
    }
  }

  Future<Map<String, dynamic>> registre(String nomUsuari, String contrassenya, BuildContext context) async {
    final response = await http.post(
      Uri.parse('$url/registre'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nomUsuari': nomUsuari,
        'contrassenya': contrassenya,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en registrar l\'usuari'))
      );
      throw Exception('Error en registrar l\'usuari');
    }
  }
}
