import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:castor_exam/core/resources/data_state.dart';
import 'package:castor_exam/core/error/failures.dart';
import 'package:castor_exam/features/search/domain/entities/search_result_entity.dart';
import 'package:castor_exam/features/search/domain/usecases/search_items.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchItemsUseCase _searchItemsUseCase;

  SearchBloc(this._searchItemsUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    final result = await _searchItemsUseCase(params: event.query);

    switch (result) {
      case DataSuccess(data: final results):
        emit(SearchLoaded(results!));
      case DataFailed(failure: final failure):
        emit(SearchError(failure!));
    }
  }
}
