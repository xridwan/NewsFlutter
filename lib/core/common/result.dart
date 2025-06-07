sealed class Result<SuccessData, ErrorType> {
  const Result();

  ReturnType fold<ReturnType>(
    ReturnType Function(ErrorType error) onFailure,
    ReturnType Function(SuccessData data) onSuccess,
  );
}

final class SuccessResult<SuccessData> extends Result<SuccessData, Never> {
  final SuccessData data;

  const SuccessResult(this.data);

  @override
  ReturnType fold<ReturnType>(
    ReturnType Function(Never error) onFailure,
    ReturnType Function(SuccessData data) onSuccess,
  ) {
    return onSuccess(data);
  }
}

final class FailureResult<ErrorType> extends Result<Never, ErrorType> {
  final ErrorType error;

  const FailureResult(this.error);

  @override
  ReturnType fold<ReturnType>(
    ReturnType Function(ErrorType error) onFailure,
    ReturnType Function(Never data) onSuccess,
  ) {
    return onFailure(error);
  }
}
