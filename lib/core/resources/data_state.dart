import 'package:dio/dio.dart';

/// Interface of current data state from api
abstract interface class DataState<T> {
  /// Data recieved
  final T? data;

  /// Error
  final DioException? error;

  DataState({
    this.data,
    this.error,
  });
}

/// Succesful data state
class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

/// Error data state
class DataFailed<T> extends DataState<T> {
  DataFailed(DioException error) : super(error: error);
}
