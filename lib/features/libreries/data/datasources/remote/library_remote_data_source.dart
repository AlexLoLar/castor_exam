// features/library/data/datasources/remote/library_remote_data_source.dart
import 'package:castor_exam/core/error/exceptions.dart';
import 'package:castor_exam/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:castor_exam/features/libreries/data/models/library_album_model.dart';
import 'package:castor_exam/features/libreries/data/models/library_track_model.dart';
import 'package:dio/dio.dart';

class LibraryRemoteDataSource {
  final Dio _dio;
  final AuthLocalDataSource _authLocalDataSource;

  LibraryRemoteDataSource({
    required Dio dio,
    required AuthLocalDataSource authLocalDataSource,
  })  : _dio = dio,
        _authLocalDataSource = authLocalDataSource;

  Future<List<LibraryTrackModel>> getUserTracks() async {
    try {
      final authData = await _authLocalDataSource.getAuthData();
      if (authData == null) {
        throw UnauthorizedException();
      }

      final response = await _dio.get(
        'https://api.spotify.com/v1/me/tracks',
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
        }),
        queryParameters: {
          'limit': 50,
          'market': 'US',
        },
      );

      return (response.data['items'] as List)
          .map((item) => LibraryTrackModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException();
    }
  }

  Future<List<LibraryAlbumModel>> getUserAlbums() async {
    try {
      final authData = await _authLocalDataSource.getAuthData();
      if (authData == null) {
        throw UnauthorizedException();
      }

      final response = await _dio.get(
        'https://api.spotify.com/v1/me/albums',
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
        }),
        queryParameters: {
          'limit': 50,
          'market': 'ES',
        },
      );

      return (response.data['items'] as List)
          .map((item) => LibraryAlbumModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException();
    }
  }
}
