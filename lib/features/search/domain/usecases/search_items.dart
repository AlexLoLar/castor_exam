import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/features/search/domain/entities/search_result_entity.dart';
import 'package:castor_exam/features/search/domain/repository/search_repository.dart';
import '../../../../core/usecase/usecase.dart';

class SearchItemsUseCase
    implements Usecase<DataState<SearchResultEntity>, String> {
  final SearchRepository _searchRepository;

  SearchItemsUseCase(this._searchRepository);

  @override
  Future<DataState<SearchResultEntity>> call({String? params}) {
    return _searchRepository.searchItems(params ?? '');
  }
}
