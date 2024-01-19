import 'package:equatable/equatable.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';

abstract class PaymentState extends Equatable {
  /// Payment entity
  final PaymentEntity? paymentEntity;

  /// Error
  final String? error;

  const PaymentState({
    this.paymentEntity,
    this.error,
  });

  @override
  List<Object?> get props => [paymentEntity, error];
}

/// Proccessing payment state (default)
class PaymentProcessing extends PaymentState {
  const PaymentProcessing();
}

/// Successful payment state returns [PaymentEntity] object
class PaymentSuccessful extends PaymentState {
  const PaymentSuccessful(PaymentEntity payment)
      : super(paymentEntity: payment);
}

/// Failed payment attempt returns error string
class PaymentFailure extends PaymentState {
  const PaymentFailure(String error) : super(error: error);
}
