import 'package:json_annotation/json_annotation.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';

part 'room_model.g.dart';

/// Hotel model for json serialization/deserialization data recieved over network
/// Extends [RoomEntity] <- Read more about its attributes there
@JsonSerializable(fieldRename: FieldRename.snake)
class RoomModel extends RoomEntity {
  const RoomModel({
    int? id,
    String? name,
    num? price,
    String? pricePer,
    List<String?>? peculiarities,
    List<String?>? imageUrls,
  }) : super(
          id: id,
          name: name,
          price: price,
          pricePer: pricePer,
          peculiarities: peculiarities,
          imageUrls: imageUrls,
        );

  /// Copies existing attributes of [RoomModel] and overrides its values
  RoomModel copyWith({
    int? id,
    String? name,
    num? price,
    String? pricePer,
    List<String?>? peculiarities,
    List<String?>? imageUrls,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      pricePer: pricePer ?? this.pricePer,
      peculiarities: peculiarities ?? this.peculiarities,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
