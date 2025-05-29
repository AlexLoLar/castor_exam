import 'package:dio/dio.dart';
import 'package:castor_exam/core/error/exceptions.dart';
import 'package:castor_exam/features/authentication/data/datasources/local/auth_local_data_source.dart';

class FavoritesRemoteDataSource {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;

  FavoritesRemoteDataSource({
    required this.dio,
    required this.authLocalDataSource,
  });

  Future<void> addTrackToFavorites(String trackId) async {
    try {
      final authData = await authLocalDataSource.getAuthData();
      if (authData == null) throw UnauthorizedException();

      print(authData.accessToken);

      await dio.put(
        'https://api.spotify.com/v1/me/tracks',
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
          'Content-Type': 'application/json',
        }),
        queryParameters: {'ids': trackId},
        data: {
          'ids': [trackId]
        },
      );

      print('adfl99');
    } on DioException catch (e) {
      print('adfa3l99');
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException();
    }
  }

  Future<void> removeTrackFromFavorites(String trackId) async {
    try {
      final authData = await authLocalDataSource.getAuthData();
      if (authData == null) throw UnauthorizedException();

      await dio.delete(
        'https://api.spotify.com/v1/me/tracks',
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
          'Content-Type': 'application/json',
        }),
        queryParameters: {'ids': trackId},
        data: {
          'ids': [trackId]
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException();
    }
  }

  Future<void> addAlbumToFavorites(String albumId) async {
    try {
      final authData = await authLocalDataSource.getAuthData();
      if (authData == null) throw UnauthorizedException();

      await dio.put(
        'https://api.spotify.com/v1/me/albums',
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
          'Content-Type': 'application/json',
        }),
        queryParameters: {'ids': albumId},
        data: {
          'ids': [albumId]
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException();
    }
  }

  Future<void> removeAlbumFromFavorites(String albumId) async {
    try {
      final authData = await authLocalDataSource.getAuthData();
      if (authData == null) throw UnauthorizedException();

      await dio.delete(
        'https://api.spotify.com/v1/me/albums',
        options: Options(headers: {
          'Authorization': 'Bearer ${authData.accessToken}',
          'Content-Type': 'application/json',
        }),
        queryParameters: {'ids': albumId},
        data: {
          'ids': [albumId]
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServerException();
    }
  }
}
