class DataResponse<T> {
  DataResponse._();

  factory DataResponse.success(T data) = RemoteResponseSuccess<T>;

  factory DataResponse.error(String errorMessage) = RemoteResponseError<T>;

  RemoteResponseSuccess<T> asSuccess() => this as RemoteResponseSuccess<T>;

  RemoteResponseError<T> asError() => this as RemoteResponseError<T>;

  bool isSuccess() => this is RemoteResponseSuccess<T>;

  bool isError() => this is RemoteResponseError<T>;
}

class RemoteResponseError<T> extends DataResponse<T> {
  final String errorMessage;

  RemoteResponseError(this.errorMessage) : super._();
}

class RemoteResponseSuccess<T> extends DataResponse<T> {
  final T data;

  RemoteResponseSuccess(this.data) : super._();
}
