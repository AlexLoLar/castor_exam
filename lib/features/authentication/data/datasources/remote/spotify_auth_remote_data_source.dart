import 'package:castor_exam/features/authentication/data/models/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert';

class SpotifyAuthRemoteDataSource {
  static String url = "https://accounts.spotify.com/authorize";
  static const clientId = '2840c7a66a5442a2983e31c0a911fc9c';
  static const clientSecret = '4e3f6c468d5e4e7a911420f85ead81b2';
  static const redirectUri = 'castorexam://callback';
  static const responseType = "code";
  static const state = "34fFs29kd09";
  static const scope =
      "streaming playlist-read-private playlist-read-collaborative user-library-read user-library-modify";

  final Dio _dio = Dio();

  Future<String> getAuthorizationCode() async {
    final url = Uri.https('accounts.spotify.com', '/authorize', {
      'response_type': responseType,
      'client_id': clientId,
      'scope': scope,
      'redirect_uri': redirectUri,
      'state': state,
      'show_dialog': 'true'
    });

    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: 'castorexam',
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) {
        throw Exception('No se pudo obtener el código de autorización');
      }
      return code;
    } catch (e) {
      throw Exception('Error durante la autenticación: $e');
    }
  }

  Future<AuthModel> getAccessToken(String code) async {
    final response = await _dio.post(
      'https://accounts.spotify.com/api/token',
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        },
      ),
      data: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data);
    } else {
      throw Exception('Error al obtener token: ${response.data}');
    }
  }
}
