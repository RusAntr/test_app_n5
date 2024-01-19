import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_n5/di_container.dart';
import 'package:test_app_n5/config/theme/app_theme.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/hotel/hotel_event.dart';

import 'features/booking/presentation/bloc/hotel/hotel_bloc.dart';
import 'features/booking/presentation/pages/hotel_screen_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initilizeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of this test application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HotelBloc>(
      create: (context) => serviceLocator()..add(const GetHotelDataEvent()),
      child: MaterialApp(
        title: 'Test app #5',
        theme: AppThemes.defaultTheme,
        home: HotelScreenView(),
      ),
    );
  }
}
