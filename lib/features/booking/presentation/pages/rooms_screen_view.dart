import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_n5/core/utils/extensions.dart';
import 'package:test_app_n5/di_container.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/booking/booking_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/booking/booking_event.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/payment/payment_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/rooms/rooms_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/rooms/rooms_state.dart';
import 'package:test_app_n5/features/booking/presentation/widgets/page_view_image_carousel.dart';

import 'booking_screen_view.dart';

List<RoomEntity?>? rooms = [];

/// Screen
class RoomsScreenView extends StatelessWidget {
  const RoomsScreenView({super.key, required this.hotelName});
  final String hotelName;

  /// Navigates user to [BookingScreenView]
  /// Gets booking data by creating a new [GetBookingDataEvent]
  /// Provides [PaymentBloc]
  void chooseRoom(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(providers: [
          BlocProvider<BookingBloc>(
            create: (context) => serviceLocator()
              ..add(
                const GetBookingDataEvent(),
              ),
          ),
          BlocProvider<PaymentBloc>(
            create: (context) => serviceLocator(),
          ),
        ], child: const BookingScreenView()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App bar
      appBar: AppBar(
        title: Text(hotelName),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            size: 22,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      body: BlocBuilder<RoomsBloc, GetRoomsDataState>(
        builder: (context, state) {
          /// Loading state
          if (state is GetRoomsDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// Error state
          if (state is GetRoomsDataError) {
            return const SizedBox();
          }

          /// Data state
          if (state is GetRoomsDataSuccess) {
            rooms = state.rooms;
            return SafeArea(
              /// Generates rooms
              child: ListView.builder(
                itemCount: rooms?.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Image carousel
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: SizedBox(
                                height: 257.0,
                                child: PageViewImageCarousel(
                                    imageUrls: rooms![index]!.imageUrls!),
                              ),
                            ),

                            /// Room name
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Text(
                                rooms![index]!.name!,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),

                            /// Peculiarities
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: List.generate(
                                  rooms![index]!.peculiarities!.length,
                                  (index2) {
                                    var peculiarities =
                                        rooms![index]!.peculiarities;
                                    return Text(
                                      peculiarities![index2]!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    );
                                  },
                                ),
                              ),
                            ),

                            /// About hotel chip
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Chip(
                                padding: const EdgeInsets.all(5.0),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Подробнее о номере',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// Price & price per text
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: RichText(
                                text: TextSpan(
                                  text: '${rooms?[index]?.price?.currency()}₽',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                  children: [
                                    const WidgetSpan(
                                      child: SizedBox(
                                        width: 8.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: rooms?[index]?.pricePer,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  ],
                                ),
                              ),
                            ),

                            /// Choose room button
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                child: ElevatedButton(
                                  onPressed: () => chooseRoom(context),
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .copyWith(
                                        textStyle: MaterialStateProperty.all(
                                          Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ),
                                  child: Text(
                                    'Выбрать номер',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
