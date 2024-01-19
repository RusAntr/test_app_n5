import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_app_n5/features/booking/data/models/models.dart';

part 'booking_api.g.dart';

/// API service
@RestApi(baseUrl: 'https://run.mocky.io/v3')
abstract interface class BookingApi {
  factory BookingApi(Dio dio) = _BookingApi;

  /// Calls for hotel data
  @GET('/d144777c-a67f-4e35-867a-cacc3b827473')
  Future<HttpResponse<HotelModel>> getHotelData();

  /// Calls for rooms data
  @GET('/8b532701-709e-4194-a41c-1a903af00195')
  Future<HttpResponse<List<RoomModel>>> getRoomData();

  /// Calls for booking data
  @GET('/63866c74-d593-432c-af8e-f279d1a8d2ff')
  Future<HttpResponse<BookingModel>> getBookingData();
}
