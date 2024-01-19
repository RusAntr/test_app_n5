/// Describes events regarding handling and processing rooms data
abstract class RoomsDataEvent {
  const RoomsDataEvent();
}

/// Making a call to repository for rooms data event
class GetRoomsDataEvent extends RoomsDataEvent {
  const GetRoomsDataEvent();
}
