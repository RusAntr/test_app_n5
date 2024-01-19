import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  const BookingEntity({
    this.id,
    this.hotelName,
    this.hotelAdress,
    this.horating,
    this.ratingName,
    this.departure,
    this.arrivalCountry,
    this.tourDateStart,
    this.tourDateStop,
    this.numberOfNights,
    this.room,
    this.nutrition,
    this.tourPrice,
    this.fuelCharge,
    this.serviceCharge,
  });

  /// Booking id
  final int? id;

  /// Hotel's name
  final String? hotelName;

  /// Hotel's address
  final String? hotelAdress;

  /// Hotel's rating
  final num? horating;

  /// Hotel's rating name
  final String? ratingName;

  /// City/country of departure
  final String? departure;

  /// Arrival country
  final String? arrivalCountry;

  /// Tour start date
  final String? tourDateStart;

  /// Tour ending date
  final String? tourDateStop;

  /// Number of nignts. Tour's lenght
  final int? numberOfNights;

  /// Booked room
  final String? room;

  /// Hotel's nutrition
  final String? nutrition;

  /// Tour's minimal price
  final num? tourPrice;

  /// Airline fuel charge
  final num? fuelCharge;

  /// Provider's service charge
  final num? serviceCharge;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        hotelName,
        hotelAdress,
        horating,
        ratingName,
        departure,
        arrivalCountry,
        tourDateStart,
        tourDateStop,
        numberOfNights,
        room,
        nutrition,
        tourPrice,
        fuelCharge,
        serviceCharge,
      ];
}
