// features/library/data/repository/library_repository_impl.dart
import 'package:castor_exam/core/error/exceptions.dart';
import 'package:castor_exam/core/error/failures.dart';
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/features/libreries/data/datasources/remote/library_remote_data_source.dart';
import 'package:castor_exam/features/libreries/data/models/library_album_model.dart';
import 'package:castor_exam/features/libreries/data/models/library_track_model.dart';
import 'package:castor_exam/features/libreries/domain/repository/library_repository.dart';
import 'package:dio/dio.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource _remoteDataSource;

  LibraryRepositoryImpl(this._remoteDataSource);

  @override
  Future<DataState<List<LibraryTrackModel>>> getUserTracks() async {
    try {
      final results = await _remoteDataSource.getUserTracks();
      return DataSuccess(results);
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
  Future<DataState<List<LibraryAlbumModel>>> getUserAlbums() async {
    try {
      final results = await _remoteDataSource.getUserAlbums();
      return DataSuccess(results);
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
