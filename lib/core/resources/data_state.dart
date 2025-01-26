abstract class DataState<T> {
  final T? data;
  final dynamic error;

  DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  DataError(dynamic error) : super(error: error);
}
