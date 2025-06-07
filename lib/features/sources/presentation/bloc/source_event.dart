sealed class SourceEvent {
  const SourceEvent();
}

final class GetSources extends SourceEvent {
  const GetSources();
}

final class SearchSources extends SourceEvent {
  final String query;

  SearchSources(this.query);
}
