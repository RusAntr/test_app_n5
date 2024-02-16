import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_n5/core/utils/extensions.dart';
import 'package:test_app_n5/core/utils/phone_input_formatter.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/booking/booking_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/booking/booking_state.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/payment/payment_bloc.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/payment/payment_event.dart';
import 'package:test_app_n5/features/booking/presentation/bloc/payment/payment_state.dart';
import 'package:test_app_n5/features/booking/presentation/pages/successful_payment_screen_view.dart';
import 'package:test_app_n5/features/booking/presentation/widgets/custom_text_form_field_widget.dart';
import 'package:test_app_n5/features/booking/presentation/widgets/tourist_info_form_widget.dart';

import '../widgets/text_table_widget.dart';

class BookingScreenView extends StatefulWidget {
  const BookingScreenView({super.key});

  @override
  State<BookingScreenView> createState() => _BookingScreenViewState();
}

class _BookingScreenViewState extends State<BookingScreenView> {
  final _phoneEmailFormKey = GlobalKey<FormState>();

  /// List of [TouristInfoFormWidget]s
  final List<TouristInfoFormWidget> _forms = List.empty(growable: true);

  /// Text editing controllers for manipulating the state of
  ///  [TextFormField] widgets
  final TextEditingController _pnoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  /// [BookingEntity] from API
  var bookingEntity = const BookingEntity();

  /// Sum of all charges
  num _totalPrice() =>
      (bookingEntity.serviceCharge ?? 0) +
      (bookingEntity.tourPrice ?? 0) +
      (bookingEntity.fuelCharge ?? 0);

  /// Empty [UserEntity]
  var user = UserEntity(firstTry: true);

  /// Validates all [TouristInfoFormWidget] in [_forms] list
  bool _validateAllForms() {
    bool allValid = true;

    /// Iterating through every element and validating fields inside
    for (var element in _forms) {
      allValid = (allValid &&
          element.isValidated() &&
          _phoneEmailFormKey.currentState!.validate());
    }
    // _phoneEmailFormKey.currentState?.save();

    return allValid;
  }

  /// Adds new [TouristInfoFormWidget] to [_forms] list
  void _addForm() {
    setState(
      () {
        _forms.add(
          TouristInfoFormWidget(
            index: (_forms.length),
            user: user,
          ),
        );
      },
    );
  }

  /// Checks if all forms have valid data ->
  /// Creates a new payment event
  /// If event is [PaymentSuccessful] navigates user to another screen
  void _makePayment() {
    var paymentBloc = context.read<PaymentBloc>();
    bool isValid = _validateAllForms();
    paymentBloc.add(
      MakePaymentEvent(isValidClient: isValid),
    );
    paymentBloc.stream.listen((event) async {
      if (event is PaymentSuccessful) {
        print('success');
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessfulPaymentScreenView(
              id: paymentBloc.state.paymentEntity!.id!,
            ),
          ),
        );
      } else {
        print('failure');
      }
    });
  }

  /// Disposes controllers when not needed to prevent memory leaks
  @override
  void dispose() {
    _pnoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    /// Adds first form
    _addForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, GetBookingDataState>(
      builder: (context, state) {
        /// Loading state
        if (state is GetBookingDataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        /// Error state
        if (state is GetBookingDataError) {
          return const SizedBox();
        }

        /// Data state
        if (state is GetBookingDataSuccess && state.bookingEntity != null) {
          bookingEntity = state.bookingEntity!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Бронирование'),
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  CupertinoIcons.back,
                  size: 22,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),

            /// Pay button
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                border: Border(
                    top: BorderSide(
                  color: Theme.of(context).colorScheme.surface,
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () => _makePayment(),
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        textStyle: MaterialStateProperty.all(
                          Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                  child: Text(
                    'Оплатить ${_totalPrice().currency()}₽',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  /// Section 1 (main hotel data)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Rating chip
                        Chip(
                          padding: const EdgeInsets.all(5.0),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  '${bookingEntity.horating} ${bookingEntity.ratingName}',
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

                        /// Hotel name title text
                        Text(
                          bookingEntity.hotelName!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        /// Hotel address text
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            bookingEntity.hotelAdress!,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Section 2 (booking data table)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Table(
                      columnWidths: const {0: IntrinsicColumnWidth(flex: 0.6)},
                      children: [
                        /// Departure
                        TableRow(
                          children: [
                            const TextTableWidget(
                                text: 'Вылет из', isTitle: true),
                            TextTableWidget(
                                text: bookingEntity.departure!, isTitle: false),
                          ],
                        ),

                        /// Arrival
                        TableRow(
                          children: [
                            const TextTableWidget(
                                text: 'Страна, город', isTitle: true),
                            TextTableWidget(
                                text: bookingEntity.arrivalCountry!,
                                isTitle: false),
                          ],
                        ),

                        /// Dates
                        TableRow(
                          children: [
                            const TextTableWidget(text: 'Даты', isTitle: true),
                            TextTableWidget(
                                text:
                                    '${bookingEntity.tourDateStart!} – ${bookingEntity.tourDateStop!}',
                                isTitle: false),
                          ],
                        ),

                        /// Nights num
                        TableRow(
                          children: [
                            const TextTableWidget(
                              text: 'Кол-во ночей',
                              isTitle: true,
                            ),
                            TextTableWidget(
                              text: bookingEntity.numberOfNights!.ruPlural(
                                ['ночей', 'ночи', 'ночь'],
                              ),
                              isTitle: false,
                            ),
                          ],
                        ),

                        /// Hotel name
                        TableRow(
                          children: [
                            const TextTableWidget(text: 'Отель', isTitle: true),
                            TextTableWidget(
                                text: bookingEntity.hotelName!, isTitle: false),
                          ],
                        ),

                        /// Room
                        TableRow(
                          children: [
                            const TextTableWidget(text: 'Номер', isTitle: true),
                            TextTableWidget(
                                text: bookingEntity.room!, isTitle: false),
                          ],
                        ),

                        /// Nutrition
                        TableRow(
                          children: [
                            const TextTableWidget(
                                text: 'Питание', isTitle: true),
                            TextTableWidget(
                                text: bookingEntity.nutrition!, isTitle: false),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Section 3 (user data)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Form(
                      key: _phoneEmailFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Client info title
                          Text(
                            'Информация о покупателе',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),

                          /// Phone number
                          CustomTextFormFieldWidget(
                            label: 'Номер телефона',
                            formatters: [PhoneInputFormatter()],
                            keyboardType: TextInputType.phone,
                            controller: _pnoneNumberController,
                            onSubmit: (value) {
                              _forms[0].user.firstTry = false;
                              _forms[0].user.phoneNumber = value;
                            },
                            validator: (value) {
                              bool firstTry = _forms[0].user.firstTry!;
                              return (!firstTry && value!.length < 18)
                                  ? 'error'
                                  : null;
                            },
                          ),

                          /// Email
                          CustomTextFormFieldWidget(
                            label: 'Почта',
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            onSubmit: (value) {
                              _forms[0].user.firstTry = false;
                              _forms[0].user.email = value;
                            },
                            validator: (value) {
                              bool firstTry = _forms[0].user.firstTry!;
                              return value!.isValidEmail() || firstTry
                                  ? null
                                  : 'error';
                            },
                          ),

                          Text(
                            'Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ),

                  /// Section 4 (tourists data)
                  Column(
                    children: _forms,
                  ),

                  /// Add new tourist button
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Add new toursit title text
                        Text(
                          'Добавить туриста',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        /// Add new tourist button
                        IconButton.filled(
                          padding: const EdgeInsets.all(0),
                          constraints: const BoxConstraints(
                            maxHeight: 32,
                            maxWidth: 32,
                            minHeight: 32,
                            minWidth: 32,
                          ),
                          iconSize: 22,
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primary,
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),

                          /// Adds a new [UserModel] to [_users] list
                          /// Can add 9 users max
                          onPressed: () {
                            setState(() {
                              if (_forms.length < 9) {
                                _addForm();
                              }
                            });
                          },
                          color: Theme.of(context).colorScheme.onBackground,
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),

                  /// Section 5 (prices table)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Table(
                      children: [
                        /// Tour price
                        TableRow(
                          children: [
                            const TextTableWidget(
                              text: 'Тур',
                              isTitle: true,
                            ),
                            TextTableWidget(
                              text: '${bookingEntity.tourPrice?.currency()}₽',
                              textAlign: TextAlign.right,
                              isTitle: false,
                            ),
                          ],
                        ),

                        /// Fuel charge
                        TableRow(
                          children: [
                            const TextTableWidget(
                              text: 'Топливный сбор',
                              isTitle: true,
                            ),
                            TextTableWidget(
                              text: '${bookingEntity.fuelCharge?.currency()}₽',
                              isTitle: false,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),

                        /// Service charge
                        TableRow(
                          children: [
                            const TextTableWidget(
                              text: 'Сервисный сбор',
                              isTitle: true,
                            ),
                            TextTableWidget(
                              text:
                                  '${bookingEntity.serviceCharge?.currency()}₽',
                              textAlign: TextAlign.right,
                              isTitle: false,
                            ),
                          ],
                        ),

                        /// Total price
                        TableRow(
                          children: [
                            const TextTableWidget(
                              text: 'К оплате',
                              isTitle: true,
                            ),
                            TextTableWidget(
                              text: '${_totalPrice().currency()}₽',
                              isTitle: false,
                              textAlign: TextAlign.right,
                              extraStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
