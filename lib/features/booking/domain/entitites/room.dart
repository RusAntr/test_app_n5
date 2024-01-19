import 'package:equatable/equatable.dart';

class RoomEntity extends Equatable {
  const RoomEntity({
    this.id,
    this.name,
    this.price,
    this.pricePer,
    this.peculiarities,
    this.imageUrls,
  });

  /// Room's id
  final int? id;

  /// Room's name
  final String? name;

  /// Room's total price for all nights
  final num? price;

  /// Room's price description
  final String? pricePer;

  /// Room's/hotel's pecularities
  final List<String?>? peculiarities;

  /// Room's photos
  final List<String?>? imageUrls;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        pricePer,
        peculiarities,
        imageUrls,
      ];
}
