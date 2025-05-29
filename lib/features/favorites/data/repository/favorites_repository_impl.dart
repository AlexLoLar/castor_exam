import 'package:castor_exam/core/error/exceptions.dart';
import 'package:castor_exam/core/error/failures.dart';
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/features/favorites/data/datasources/remote/favorites_remote_data_source.dart';
import 'package:castor_exam/features/favorites/domain/repository/favorites_repository.dart';
import 'package:dio/dio.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DataState<void>> addTrackToFavorites(String trackId) async {
    try {
      await remoteDataSource.addTrackToFavorites(trackId);
      return const DataSuccess(null);
    } on UnauthorizedException {
      return const DataFailed(UnauthorizedFailure());
    } on ServerException {
      return const DataFailed(ServerFailure());
    } on DioException catch (e) {
      return DataFailed(ServerFailure(
          e.message ?? 'Unknown Dio error', e.response?.statusCode));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> removeTrackFromFavorites(String trackId) async {
    try {
      await remoteDataSource.removeTrackFromFavorites(trackId);
      return const DataSuccess(null);
    } on UnauthorizedException {
      return const DataFailed(UnauthorizedFailure());
    } on ServerException {
      return const DataFailed(ServerFailure());
    } on DioException catch (e) {
      return DataFailed(ServerFailure(
          e.message ?? 'Unknown Dio error', e.response?.statusCode));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> addAlbumToFavorites(String albumId) async {
    try {
      await remoteDataSource.addAlbumToFavorites(albumId);
      return const DataSuccess(null);
    } on UnauthorizedException {
      return const DataFailed(UnauthorizedFailure());
    } on ServerException {
      return const DataFailed(ServerFailure());
    } on DioException catch (e) {
      return DataFailed(ServerFailure(
          e.message ?? 'Unknown Dio error', e.response?.statusCode));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString()));
    }
  }

  @override
  Future<DataState<void>> removeAlbumFromFavorites(String albumId) async {
    try {
      await remoteDataSource.removeAlbumFromFavorites(albumId);
      return const DataSuccess(null);
    } on UnauthorizedException {
      return const DataFailed(UnauthorizedFailure());
    } on ServerException {
      return const DataFailed(ServerFailure());
    } on DioException catch (e) {
      return DataFailed(ServerFailure(
          e.message ?? 'Unknown Dio error', e.response?.statusCode));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString()));
    }
  }
}
