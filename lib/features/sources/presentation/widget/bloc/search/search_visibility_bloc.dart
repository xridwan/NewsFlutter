import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/sources/presentation/widget/bloc/search/search_visibility_event.dart';
import 'package:news_app/features/sources/presentation/widget/bloc/search/search_visibility_state.dart';

class SearchVisibilyBloc
    extends Bloc<SearchVisibilityEvent, SearchVisibilityState> {
  SearchVisibilyBloc() : super(SearchVisibilityHidden()) {
    on<ToggleSearchVisibility>((event, emit) {
      if (state is SearchVisibilityHidden) {
        emit(SearchVisibilityShown());
      } else {
        emit(SearchVisibilityHidden());
      }
    });
  }
}
