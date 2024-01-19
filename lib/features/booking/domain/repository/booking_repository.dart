import 'package:test_app_n5/core/resources/data_state.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';

/// Repository interface
/// usecase <- repo <- api
abstract interface class BookingRepository {
  /// Retrieves hotel data
  Future<DataState<HotelEntity>> getHotelData();

  /// Retrieves rooms data
  Future<DataState<List<RoomEntity>>> getRoomsData();

  /// Retrieves booking data
  Future<DataState<BookingEntity>> getBookingData();

  /// Retrieves payment data
  Future<DataState<PaymentEntity>> makePayment();
}
