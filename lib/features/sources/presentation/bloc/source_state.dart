import 'package:news_app/features/sources/domain/model/source.dart';

sealed class SourceState {
  const SourceState();
}

final class SourceInitial extends SourceState {
  const SourceInitial();
}

final class SourceLoading extends SourceState {
  const SourceLoading();
}

final class SourceLoaded extends SourceState {
  final List<Source> sources;

  const SourceLoaded(this.sources);
}

final class SourceError extends SourceState {
  final String message;

  const SourceError(this.message);
}
