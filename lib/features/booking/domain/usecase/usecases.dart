import 'package:test_app_n5/core/resources/data_state.dart';
import 'package:test_app_n5/core/usecase/usecase.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';
import 'package:test_app_n5/features/booking/domain/repository/booking_repository.dart';

/// Default implementation of business logic
/// Gets booking data from api
class GetBookingDataUsecase implements UseCase<DataState<BookingEntity>, void> {
  final BookingRepository _bookingRepository;

  GetBookingDataUsecase(this._bookingRepository);

  @override
  Future<DataState<BookingEntity>> call({void params}) async {
    return await _bookingRepository.getBookingData();
  }
}

/// Default implementation of business logic
/// Gets hotel data from api
class GetHotelDataUsecase implements UseCase<DataState<HotelEntity>, void> {
  final BookingRepository _bookingRepository;

  GetHotelDataUsecase(this._bookingRepository);

  @override
  Future<DataState<HotelEntity>> call({void params}) async {
    return await _bookingRepository.getHotelData();
  }
}

/// Default implementation of business logic
/// Gets rooms data from api
class GetRoomsDataUseCase
    implements UseCase<DataState<List<RoomEntity>>, void> {
  final BookingRepository _bookingRepository;

  GetRoomsDataUseCase(this._bookingRepository);

  @override
  Future<DataState<List<RoomEntity>>> call({void params}) async {
    return await _bookingRepository.getRoomsData();
  }
}

/// Default implementation of business logic
/// Creates a payment
class MakePaymentUseCase implements UseCase<DataState<PaymentEntity>, void> {
  final BookingRepository _bookingRepository;

  MakePaymentUseCase(this._bookingRepository);

  @override
  Future<DataState<PaymentEntity>> call({void params}) async {
    return await _bookingRepository.makePayment();
  }
}
