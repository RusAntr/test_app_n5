/// Describes events regarding handling and processing booking data
abstract class BookingDataEvent {
  const BookingDataEvent();
}

/// Making a call to repostory for booking data event
class GetBookingDataEvent extends BookingDataEvent {
  const GetBookingDataEvent();
}
