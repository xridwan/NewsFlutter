import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/base/base_use_case.dart';
import 'package:news_app/features/sources/presentation/bloc/source_event.dart';
import 'package:news_app/features/sources/presentation/bloc/source_state.dart';

import '../../domain/model/source.dart';
import '../../domain/usecase/get_source_usecase.dart';

class SourceBloc extends Bloc<SourceEvent, SourceState> {
  final GetSourceUseCase _getSourceUseCase;
  final List<Source> _sources = [];

  SourceBloc(this._getSourceUseCase) : super(const SourceInitial()) {
    on<SourceEvent>((event, emit) async {
      switch (event) {
        case GetSources():
          emit(const SourceLoading());
          final result = await _getSourceUseCase(NoParams());
          result.fold((failure) => emit(SourceError(failure.message)), (
            sources,
          ) {
            _sources.clear();
            _sources.addAll(sources);
            emit(SourceLoaded(_sources));
          });
          break;
        case SearchSources(query: String query):
          final filteredSources =
              (_sources)
                  .where(
                    (source) =>
                        source.name.toLowerCase().contains(query.toLowerCase()),
                  )
                  .toList();
          emit(SourceLoaded(filteredSources));
          break;
      }
    });
  }
}
