sealed class Result<S, F> {
  const Result();

  R fold<R>(R Function(F error) onFailure, R Function(S data) onSuccess);
}

final class Right<S> extends Result<S, Never> {
  final S data;

  const Right(this.data);

  @override
  R fold<R>(R Function(Never error) onFailure, R Function(S data) onSuccess) {
    return onSuccess(data);
  }
}

final class Left<F> extends Result<Never, F> {
  final F error;

  const Left(this.error);

  @override
  R fold<R>(R Function(F error) onFailure, R Function(Never data) onSuccess) {
    return onFailure(error);
  }
}
