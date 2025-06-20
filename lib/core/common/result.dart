sealed class Result<S, E> {
  const Result();

  R fold<R>(R Function(E error) onFailure, R Function(S data) onSuccess);
}

final class Right<S> extends Result<S, Never> {
  final S data;

  const Right(this.data);

  @override
  R fold<R>(R Function(Never error) onFailure, R Function(S data) onSuccess) {
    return onSuccess(data);
  }
}

final class Left<E> extends Result<Never, E> {
  final E error;

  const Left(this.error);

  @override
  R fold<R>(R Function(E error) onFailure, R Function(Never data) onSuccess) {
    return onFailure(error);
  }
}
