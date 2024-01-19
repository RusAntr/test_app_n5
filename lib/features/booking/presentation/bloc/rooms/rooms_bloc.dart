import 'package:bloc/bloc.dart';
import 'package:test_app_n5/core/resources/data_state.dart';
import 'package:test_app_n5/features/booking/domain/usecase/usecases.dart';

import 'rooms_event.dart';
import 'rooms_state.dart';

/// Handles rooms data processing and presents it to ui
class RoomsBloc extends Bloc<RoomsDataEvent, GetRoomsDataState> {
  final GetRoomsDataUseCase _getRoomsDataUsecase;
  RoomsBloc(this._getRoomsDataUsecase) : super(const GetRoomsDataLoading()) {
    on<GetRoomsDataEvent>(onGetRoomsData);
  }

  /// Calls usecase -> repository -> api for data
  void onGetRoomsData(
    GetRoomsDataEvent event,
    Emitter<GetRoomsDataState> emit,
  ) async {
    final dataState = await _getRoomsDataUsecase.call();
    if (dataState is DataSuccess && dataState.data != null) {
      emit(
        GetRoomsDataSuccess(dataState.data!),
      );
    }

    /// If call was unsuccessful
    if (dataState is DataFailed) {
      emit(
        GetRoomsDataError(dataState.error!),
      );
    }
  }
}
