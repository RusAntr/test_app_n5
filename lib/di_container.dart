import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app_n5/features/booking/data/data_sources/remote/booking_api.dart';
import 'package:test_app_n5/features/booking/data/repository/booking_repository_default.dart';
import 'package:test_app_n5/features/booking/domain/repository/booking_repository.dart';
import 'package:test_app_n5/features/booking/domain/usecase/usecases.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/hotel/hotel_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/payment/payment_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/rooms/rooms_bloc.dart';

import 'features/booking/presentation/bloc/booking/booking_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initilizeDependencies() async {
  /// Dio
  serviceLocator.registerSingleton<Dio>(Dio());

  /// Dependecies
  serviceLocator.registerSingleton<BookingApi>(BookingApi(serviceLocator()));
  serviceLocator.registerSingleton<BookingRepository>(
      BookingRepositoryDefault(serviceLocator()));

  /// Use cases
  serviceLocator.registerSingleton<GetHotelDataUsecase>(
      GetHotelDataUsecase(serviceLocator()));
  serviceLocator.registerSingleton<GetBookingDataUsecase>(
      GetBookingDataUsecase(serviceLocator()));
  serviceLocator.registerSingleton<GetRoomsDataUseCase>(
      GetRoomsDataUseCase(serviceLocator()));
  serviceLocator.registerSingleton<MakePaymentUseCase>(
      MakePaymentUseCase(serviceLocator()));

  /// BLoCs
  serviceLocator
      .registerFactory<BookingBloc>(() => BookingBloc(serviceLocator()));
  serviceLocator.registerFactory<HotelBloc>(() => HotelBloc(serviceLocator()));
  serviceLocator.registerFactory<RoomsBloc>(() => RoomsBloc(serviceLocator()));
  serviceLocator
      .registerFactory<PaymentBloc>(() => PaymentBloc(serviceLocator()));
}
