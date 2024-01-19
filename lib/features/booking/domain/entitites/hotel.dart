import 'package:equatable/equatable.dart';

/// Hotel entity
class HotelEntity extends Equatable {
  const HotelEntity({
    this.id,
    this.name,
    this.adress,
    this.minimalPrice,
    this.priceForIt,
    this.rating,
    this.ratingName,
    this.imageUrls,
    this.aboutTheHotel,
  });

  /// Hotel's id
  final int? id;

  /// Hotel's name
  final String? name;

  /// Hotel's address
  final String? adress;

  /// Hotel's minimal price
  final num? minimalPrice;

  /// Hotel's rating
  final num? rating;

  /// Hotel's rating name
  final String? ratingName;

  /// Hotel's price description
  final String? priceForIt;

  /// Hotel's photos
  final List<String?>? imageUrls;

  /// Hotel's description ('peculiarities, 'description')
  final Map<String, dynamic>? aboutTheHotel;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        name,
        adress,
        rating,
        ratingName,
        priceForIt,
        imageUrls,
        aboutTheHotel,
        minimalPrice,
      ];
}
