import 'package:castor_exam/core/error/exceptions.dart';
import 'package:castor_exam/features/search/data/models/search_result_model.dart';
import 'package:castor_exam/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:dio/dio.dart';

class SpotifySearchRemoteDataSource {
  final Dio _dio;
  final AuthLocalDataSource _authLocalDataSource;

  SpotifySearchRemoteDataSource({
    required Dio dio,
    required AuthLocalDataSource authLocalDataSource,
  })  : _dio = dio,
        _authLocalDataSource = authLocalDataSource;

  Future<SearchResultModel> searchItems(String query) async {
    try {
      final authData = await _authLocalDataSource.getAuthData();
      if (authData == null) {
        throw UnauthorizedException();
      }

      final response = await _dio.get(
        'https://api.spotify.com/v1/search',
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
        }),
        queryParameters: {
          'q': query,
          'type': 'track,artist,album',
          'limit': 10,
          'market': 'ES',
          'include_external': 'audio',
        },
      );

      return SearchResultModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException();
    }
  }
}
