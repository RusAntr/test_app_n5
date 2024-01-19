/// Describes events regarding handling and processing booking data
abstract class HotelDataEvent {
  const HotelDataEvent();
}

/// Making a call to repository for hotel data event
class GetHotelDataEvent extends HotelDataEvent {
  const GetHotelDataEvent();
}
