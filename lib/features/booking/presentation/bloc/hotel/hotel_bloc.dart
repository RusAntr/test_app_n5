import 'package:bloc/bloc.dart';
import 'package:test_app_n5/core/resources/data_state.dart';
import 'package:test_app_n5/features/booking/domain/usecase/usecases.dart';

import 'hotel_event.dart';
import 'hotel_state.dart';

/// Handles hotel data processing and presents it to ui
class HotelBloc extends Bloc<HotelDataEvent, GetHotelDataState> {
  final GetHotelDataUsecase _getHotelDataUsecase;
  HotelBloc(this._getHotelDataUsecase) : super(const GetHotelDataLoading()) {
    on<GetHotelDataEvent>(onGetHotelData);
  }

  /// Calls usecase -> repository -> api for data
  void onGetHotelData(
    GetHotelDataEvent event,
    Emitter<GetHotelDataState> emit,
  ) async {
    final dataState = await _getHotelDataUsecase.call();
    if (dataState is DataSuccess && dataState.data != null) {
      emit(
        GetHotelDataSuccess(dataState.data!),
      );
    }

    /// If call was unsuccessful
    if (dataState is DataFailed) {
      emit(
        GetHotelDataError(dataState.error!),
      );
    }
  }
}
