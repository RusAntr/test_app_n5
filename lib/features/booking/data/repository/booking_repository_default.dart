import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:test_app_n5/core/resources/data_state.dart';
import 'package:test_app_n5/features/booking/data/data_sources/remote/booking_api.dart';
import 'package:test_app_n5/features/booking/data/models/models.dart';
import 'package:test_app_n5/features/booking/domain/entitites/payment.dart';
import 'package:test_app_n5/features/booking/domain/repository/booking_repository.dart';

/// Default of implementation of [BookingRepository]
class BookingRepositoryDefault implements BookingRepository {
  /// API service
  final BookingApi _bookingApi;
  BookingRepositoryDefault(this._bookingApi);

  /// Retrieves booking data over network
  /// Returns [DataState] of either [BookingModel] object or [DioException]
  @override
  Future<DataState<BookingModel>> getBookingData() async {
    try {
      final response = await _bookingApi.getBookingData();
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.response.requestOptions,
            response: response.response,
            error: response.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  /// Retrieves hotel data over network
  /// Returns [DataState] of either [HotelModel] object or [DioException]
  @override
  Future<DataState<HotelModel>> getHotelData() async {
    try {
      final response = await _bookingApi.getHotelData();
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.response.requestOptions,
            response: response.response,
            error: response.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  /// Retrieves rooms data over network
  /// Returns [DataState] of either a list of [RoomModel] objects or [DioException]
  @override
  Future<DataState<List<RoomModel>>> getRoomsData() async {
    try {
      final response = await _bookingApi.getRoomData();
      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: response.response.requestOptions,
            response: response.response,
            error: response.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  /// Returns [PaymentEntity] object with random id
  @override
  Future<DataState<PaymentEntity>> makePayment() async {
    /// Generates random id int
    var randomId = Random().nextInt(999999);
    return DataSuccess(
      PaymentEntity(
        id: randomId,
      ),
    );
  }
}
