import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app_n5/features/booking/presentation/pages/hotel_screen_view.dart';

class SuccessfulPaymentScreenView extends StatelessWidget {
  const SuccessfulPaymentScreenView({
    super.key,
    required this.id,
  });

  /// Payment id
  final num id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,

      /// App bar
      appBar: AppBar(
        title: const Text('Заказ оплачен'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.back,
            size: 22,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),

      /// Super button
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
            onPressed: () {
              /// Navigates to [HotelScreenView]
              /// Replaces the route, can't navigate back
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HotelScreenView(),
                ),
                (_) => false,
              );
            },
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  textStyle: MaterialStateProperty.all(
                    Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
            child: Text(
              'Супер!',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Image
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                height: 94.0,
                width: 94.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Image.asset(
                  'assets/images/party_popper.png',
                  height: 44.0,
                  width: 44,
                ),
              ),

              /// Title
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                child: Text(
                  'Ваш заказ принят в работу',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              /// Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: Text(
                  'Подтверждение заказа №$id может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
