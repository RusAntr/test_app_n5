import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  const PaymentEntity({this.id});

  /// Payment's id (randomly generated)
  final int? id;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id];
}
