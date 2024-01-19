import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';

abstract class GetBookingDataState extends Equatable {
  /// Booking entity
  final BookingEntity? bookingEntity;

  /// Error
  final DioException? error;

  const GetBookingDataState({
    this.bookingEntity,
    this.error,
  });

  @override
  List<Object?> get props => [error];
}

/// Default loading state
class GetBookingDataLoading extends GetBookingDataState {
  const GetBookingDataLoading();
}

/// Successful state of loaded booking data returns [BookingEntity] object
class GetBookingDataSuccess extends GetBookingDataState {
  const GetBookingDataSuccess(BookingEntity booking)
      : super(bookingEntity: booking);
}

/// Failed attempt at loading bookind data returns [DioException]
class GetBookingDataError extends GetBookingDataState {
  const GetBookingDataError(DioException error) : super(error: error);
}
