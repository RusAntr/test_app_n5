import 'package:bloc/bloc.dart';
import 'package:test_app_n5/core/resources/data_state.dart';
import 'package:test_app_n5/features/booking/domain/usecase/usecases.dart';

import 'booking_event.dart';
import 'booking_state.dart';

/// Handles booking data processing and presents it to ui
class BookingBloc extends Bloc<BookingDataEvent, GetBookingDataState> {
  final GetBookingDataUsecase _getBookingDataUsecase;
  BookingBloc(this._getBookingDataUsecase)
      : super(const GetBookingDataLoading()) {
    on<GetBookingDataEvent>(onGetBookingData);
  }

  /// Calls usecase -> repository -> api for data
  void onGetBookingData(
    GetBookingDataEvent event,
    Emitter<GetBookingDataState> emit,
  ) async {
    final dataState = await _getBookingDataUsecase.call();
    if (dataState is DataSuccess && dataState.data != null) {
      emit(
        GetBookingDataSuccess(dataState.data!),
      );
    }

    /// If call was unsuccessful
    if (dataState is DataFailed) {
      emit(
        GetBookingDataError(dataState.error!),
      );
    }
  }
}
