import 'package:castor_exam/core/error/exceptions.dart';
import 'package:castor_exam/core/error/failures.dart';
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/features/search/data/datasources/remote/spotify_search_remote_data_source.dart';
import 'package:castor_exam/features/search/domain/entities/search_result_entity.dart';
import 'package:castor_exam/features/search/domain/repository/search_repository.dart';
import 'package:dio/dio.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SpotifySearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<DataState<SearchResultEntity>> searchItems(String query) async {
    try {
      final results = await _remoteDataSource.searchItems(query);

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
