import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_n5/config/theme/test_app_n5_icons.dart';
import 'package:test_app_n5/core/utils/extensions.dart';
import 'package:test_app_n5/di_container.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/hotel/hotel_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/hotel/hotel_state.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/rooms/rooms_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/rooms/rooms_event.dart';
import 'package:test_app_n5/features/booking/presentation/widgets/hotel_table_widget.dart';
import 'package:test_app_n5/features/booking/presentation/widgets/page_view_image_carousel.dart';

import 'rooms_screen_view.dart';

class HotelScreenView extends StatelessWidget {
  const HotelScreenView({super.key});

  /// Navigates user to [RoomsScreenView]
  /// Provides [RoomsBloc] and gets rooms data by
  /// creating a new [GetRoomsDataEvent]
  void onTap(BuildContext context, String hotelName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<RoomsBloc>(
          create: (context) => serviceLocator()
            ..add(
              const GetRoomsDataEvent(),
            ),
          child: RoomsScreenView(
            hotelName: hotelName,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var hotel = const HotelEntity();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Отель'),
      ),

      /// Choose room button
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          border: Border(
              top: BorderSide(
            color: Theme.of(context).colorScheme.surface,
          )),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () => onTap(context, hotel.name ?? ''),
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                ),

            /// Button title
            child: Text(
              'К выбору номера',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HotelBloc, GetHotelDataState>(
        builder: (context, state) {
          /// Loading state
          if (state is GetHotelDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// Error state
          if (state is GetHotelDataError) {
            return const SizedBox();
          }

          /// Data state
          if (state is GetHotelDataSuccess) {
            hotel = state.hotelEntity!;
            return SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  /// Section 1 (main hotel data)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Image carousel
                        SizedBox(
                          height: 257,
                          child: PageViewImageCarousel(
                              imageUrls: hotel.imageUrls ?? []),
                        ),

                        /// Rating chip
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 8.0,
                            left: 16.0,
                          ),
                          child: Chip(
                            padding: const EdgeInsets.all(5.0),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    '${hotel.rating} ${hotel.ratingName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// Hotel name title text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            hotel.name ?? '',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),

                        /// Hotel address text
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 16,
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Text(
                            hotel.adress ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),

                        /// Price & price for text
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'от ${hotel.minimalPrice?.currency()}₽',
                              style: Theme.of(context).textTheme.headlineLarge,
                              children: [
                                const WidgetSpan(
                                  child: SizedBox(
                                    width: 8.0,
                                  ),
                                ),
                                TextSpan(
                                  text: hotel.priceForIt,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Section 2 (hotel extra data)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// About hotel title text
                        Text(
                          'Об отеле',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        /// Pecularities
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 12.0),
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: List.generate(
                              (hotel.aboutTheHotel?['peculiarities'] as List)
                                  .length,
                              (index) => Text(
                                (hotel.aboutTheHotel?['peculiarities']
                                    as List<dynamic>)[index],
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ),

                        /// Hotel description
                        Text(
                          hotel.aboutTheHotel?['description'],
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    height: 1.2,
                                  ),
                        ),
                        const SizedBox(height: 16),

                        /// Extra buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: const [
                              /// Comfort items
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 12.0, bottom: 12),
                                    child: Icon(
                                      TestAppN5.happy,
                                      size: 22.0,
                                    ),
                                  ),
                                  HotelTableWidget(
                                    title: 'Удобства',
                                    subtitle: 'Самое необходимое',
                                    showDivider: true,
                                  ),
                                ],
                              ),

                              /// What's included
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 12.0, bottom: 12),
                                    child: Icon(
                                      TestAppN5.tick,
                                      size: 22.0,
                                    ),
                                  ),
                                  HotelTableWidget(
                                    title: 'Что включено',
                                    subtitle: 'Самое необходимое',
                                    showDivider: true,
                                  ),
                                ],
                              ),

                              /// What's not included
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 12.0, bottom: 12),
                                    child: Icon(
                                      TestAppN5.cancel,
                                      size: 22.0,
                                    ),
                                  ),
                                  HotelTableWidget(
                                    title: 'Что не включено',
                                    subtitle: 'Самое необходимое',
                                    showDivider: false,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
