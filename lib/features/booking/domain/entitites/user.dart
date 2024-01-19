// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserEntity extends Equatable {
  UserEntity({
    this.name,
    this.lastName,
    this.birthdate,
    this.citizenship,
    this.passportNumber,
    this.passportValidUntilDate,
    this.email,
    this.phoneNumber,
    this.firstTry,
  });
  String? name;
  String? lastName;
  String? birthdate;
  String? citizenship;
  String? passportNumber;
  String? passportValidUntilDate;
  String? email;
  String? phoneNumber;
  bool? firstTry;

  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => [
        name,
        lastName,
        birthdate,
        citizenship,
        passportNumber,
        passportNumber,
        email,
        phoneNumber,
      ];

  UserEntity copyWith({
    String? name,
    String? lastName,
    String? birthdate,
    String? citizenship,
    String? passportNumber,
    String? passportValidUntilDate,
    String? email,
    String? phoneNumber,
  }) {
    return UserEntity(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthdate: birthdate ?? this.birthdate,
      citizenship: citizenship ?? this.citizenship,
      passportNumber: passportNumber ?? this.passportNumber,
      passportValidUntilDate:
          passportValidUntilDate ?? this.passportValidUntilDate,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
