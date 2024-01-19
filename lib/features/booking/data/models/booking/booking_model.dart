import 'package:json_annotation/json_annotation.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';

part 'booking_model.g.dart';

/// Hotel model for json serialization/deserialization data recieved over network
/// Extends [BookingEntity] <- Read more about its attributes there
@JsonSerializable(fieldRename: FieldRename.snake)
class BookingModel extends BookingEntity {
  const BookingModel({
    int? id,
    String? hotelName,
    String? hotelAdress,
    num? horating,
    String? ratingName,
    String? departure,
    String? arrivalCountry,
    String? tourDateStart,
    String? tourDateStop,
    int? numberOfNights,
    String? room,
    String? nutrition,
    num? tourPrice,
    num? fuelCharge,
    num? serviceCharge,
  }) : super(
          id: id,
          hotelName: hotelName,
          hotelAdress: hotelAdress,
          horating: horating,
          ratingName: ratingName,
          departure: departure,
          arrivalCountry: arrivalCountry,
          tourDateStart: tourDateStart,
          tourDateStop: tourDateStop,
          numberOfNights: numberOfNights,
          room: room,
          nutrition: nutrition,
          tourPrice: tourPrice,
          fuelCharge: fuelCharge,
          serviceCharge: serviceCharge,
        );

  /// Copies existing attributes of [BookingModel] and overrides its values
  BookingModel copyWith({
    int? id,
    String? name,
    String? address,
    num? rating,
    String? ratingName,
    String? departure,
    String? arrivalCountry,
    String? tourDateStart,
    String? tourDateStop,
    int? numberOfNights,
    String? room,
    String? nutrition,
    num? tourPrice,
    num? fuelCharge,
    num? serviceCharge,
  }) {
    return BookingModel(
      id: id ?? this.id,
      hotelName: name ?? hotelName,
      hotelAdress: address ?? hotelAdress,
      horating: rating ?? horating,
      ratingName: ratingName ?? this.ratingName,
      departure: departure ?? this.departure,
      arrivalCountry: arrivalCountry ?? this.arrivalCountry,
      tourDateStart: tourDateStart ?? this.tourDateStart,
      tourDateStop: tourDateStop ?? this.tourDateStop,
      numberOfNights: numberOfNights ?? this.numberOfNights,
      room: room ?? this.room,
      nutrition: nutrition ?? this.nutrition,
      tourPrice: tourPrice ?? this.tourPrice,
      fuelCharge: fuelCharge ?? this.fuelCharge,
      serviceCharge: serviceCharge ?? this.serviceCharge,
    );
  }

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}
