import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entitites/enitities.dart';

part 'hotel_model.g.dart';

/// Hotel model for json serialization/deserialization data recieved over network
/// Extends [HotelEntity] <- Read more about its attributes there
@JsonSerializable(fieldRename: FieldRename.snake)
class HotelModel extends HotelEntity {
  const HotelModel({
    int? id,
    String? name,
    String? adress,
    num? minimalPrice,
    num? rating,
    String? ratingName,
    String? priceForIt,
    List<String?>? imageUrls,
    Map<String, dynamic>? aboutTheHotel,
  }) : super(
          id: id,
          name: name,
          adress: adress,
          minimalPrice: minimalPrice,
          rating: rating,
          ratingName: ratingName,
          priceForIt: priceForIt,
          imageUrls: imageUrls,
          aboutTheHotel: aboutTheHotel,
        );

  /// Copies existing attributes of [HotelModel] and overrides its values
  HotelModel copyWith({
    int? id,
    String? name,
    String? address,
    num? minimalPrice,
    num? rating,
    String? ratingName,
    String? priceForIt,
    List<String?>? imageUrls,
    Map<String, dynamic>? aboutTheHotel,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      adress: address ?? adress,
      minimalPrice: minimalPrice ?? this.minimalPrice,
      rating: rating ?? this.rating,
      ratingName: ratingName ?? this.ratingName,
      priceForIt: priceForIt ?? this.priceForIt,
      imageUrls: imageUrls ?? this.imageUrls,
      aboutTheHotel: aboutTheHotel ?? this.aboutTheHotel,
    );
  }

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);
}
