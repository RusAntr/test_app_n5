import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';

abstract class GetHotelDataState extends Equatable {
  /// Hotel entity
  final HotelEntity? hotelEntity;

  /// Error
  final DioException? error;

  const GetHotelDataState({
    this.hotelEntity,
    this.error,
  });

  @override
  List<Object?> get props => [hotelEntity, error];
}

/// Default loading state
class GetHotelDataLoading extends GetHotelDataState {
  const GetHotelDataLoading();
}

/// Successful state of loaded hotel data returns [HotelEntity] object
class GetHotelDataSuccess extends GetHotelDataState {
  const GetHotelDataSuccess(HotelEntity hotel) : super(hotelEntity: hotel);
}

/// Failed attempt of loading hotel data returns [DioException]
class GetHotelDataError extends GetHotelDataState {
  const GetHotelDataError(DioException error) : super(error: error);
}
