import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/features/search/domain/entities/search_result_entity.dart';

abstract class SearchRepository {
  Future<DataState<SearchResultEntity>> searchItems(String query);
}
