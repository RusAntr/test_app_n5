/// Describes events regarding creating, handling and processing payments
abstract class PaymentEvent {
  const PaymentEvent();
}

/// Making a call to repository to create a payment event
/// Payment event requires a valid client with all fields filled
class MakePaymentEvent extends PaymentEvent {
  const MakePaymentEvent({required this.isValidClient});
  final bool isValidClient;
}
