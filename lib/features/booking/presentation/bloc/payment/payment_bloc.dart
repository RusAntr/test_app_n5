import 'package:bloc/bloc.dart';
import 'package:test_app_n5/features/booking/domain/usecase/usecases.dart';

import 'payment_event.dart';
import 'payment_state.dart';

/// Handles payments data and presents it to ui
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final MakePaymentUseCase _makePaymentUseCase;
  PaymentBloc(this._makePaymentUseCase) : super(const PaymentProcessing()) {
    on<MakePaymentEvent>(makePayment);
  }

  /// Calls usecase -> repository to create a payment
  void makePayment(
    MakePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    if (event.isValidClient) {
      final dataState = await _makePaymentUseCase.call();
      emit(PaymentSuccessful(dataState.data!));

      /// If call was unsuccessful
    } else {
      emit(const PaymentFailure('error'));
    }
  }
}
