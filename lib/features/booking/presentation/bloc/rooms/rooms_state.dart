import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';

abstract class GetRoomsDataState extends Equatable {
  /// List of rooms
  final List<RoomEntity?>? rooms;

  /// Error
  final DioException? error;

  const GetRoomsDataState({
    this.rooms,
    this.error,
  });

  @override
  List<Object?> get props => [rooms, error];
}

/// Loading rooms data state (default)
class GetRoomsDataLoading extends GetRoomsDataState {
  const GetRoomsDataLoading();
}

/// Successful state of loaded rooms data
/// Returns a list [RoomEntity] objects
class GetRoomsDataSuccess extends GetRoomsDataState {
  const GetRoomsDataSuccess(List<RoomEntity> rooms) : super(rooms: rooms);
}

/// Failed attempt returns [DioException]
class GetRoomsDataError extends GetRoomsDataState {
  const GetRoomsDataError(DioException error) : super(error: error);
}
