// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app_n5/core/utils/const.dart';
import 'package:test_app_n5/core/utils/date_input_formatter.dart';
import 'package:test_app_n5/core/utils/extensions.dart';
import 'package:test_app_n5/core/utils/passport_input_formatter.dart';
import 'package:test_app_n5/features/booking/domain/entitites/enitities.dart';
import 'package:test_app_n5/features/booking/presentation/widgets/custom_text_form_field_widget.dart';

/// UI widget used for BookingScreenView
/// Contains [CustomTextFormFieldWidget]s for user input
/// and a button to manipulate their visibilty
class TouristInfoFormWidget extends StatefulWidget {
  TouristInfoFormWidget({
    super.key,
    required this.index,
    required this.user,
  });

  /// Index of this widget in a list
  /// Used for ordinal naming
  final int index;

  /// Mutatable [UserEntity]
  final UserEntity user;

  /// State of this widget
  final state = _TouristInfoFormWidgetState();

  /// Wheter user inputs are valid
  bool isValidated() => state.validate();

  @override
  State<StatefulWidget> createState() => state;
}

class _TouristInfoFormWidgetState extends State<TouristInfoFormWidget> {
  /// Key for form validation
  final formKey = GlobalKey<FormState>();

  /// Boolean value that is used for logic of hiding and showing
  ///  [TextFormField] widgets. Initially is set to true (shown)
  bool _isExpanded = true;

  /// Reference to [UserEntity]
  late var user = widget.user;

  /// Validates form fields
  bool validate() {
    setState(() {});
    bool isValid = formKey.currentState!.validate();
    widget.user.firstTry = false;
    if (isValid) formKey.currentState?.save();
    return isValid;
  }

  /// Hides shows form fields
  void hideShow() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin:
          widget.index == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Tourist ordinal number title
              Text(
                '${AppConst.ordinals[widget.index]} турист',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              /// Show/hide button
              IconButton.filled(
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints(
                  maxHeight: 32,
                  maxWidth: 32,
                  minHeight: 32,
                  minWidth: 32,
                ),
                iconSize: 25,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                onPressed: () => hideShow(),
                color: Theme.of(context).colorScheme.primary,
                icon: Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                ),
              )
            ],
          ),

          /// Fields that are shown/hidden when [_isExpanded] is set to true||false
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            visible: _isExpanded,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  /// Tourist's first name
                  CustomTextFormFieldWidget(
                    label: 'Имя',
                    keyboardType: TextInputType.name,
                    validator: (value) =>
                        (!user.firstTry! && value!.isEmpty) ? 'error' : null,
                    onSubmit: (value) => user.name = value,
                  ),

                  /// Tourist's last name
                  CustomTextFormFieldWidget(
                    label: 'Фамилия',
                    keyboardType: TextInputType.name,
                    onSubmit: (value) => user.lastName = value,
                    validator: (value) =>
                        (value!.isEmpty && !user.firstTry!) ? 'error' : null,
                  ),

                  /// Tourist's date of birth
                  CustomTextFormFieldWidget(
                    label: 'Дата рождения',
                    keyboardType: TextInputType.datetime,
                    onSubmit: (value) => user.birthdate = value,
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DateInputFormatter(),
                    ],
                    validator: (value) =>
                        (user.firstTry! || value!.isValidDate())
                            ? null
                            : 'error',
                  ),

                  /// Tourist's citizenship
                  CustomTextFormFieldWidget(
                    label: 'Гражданство',
                    keyboardType: TextInputType.text,
                    onSubmit: (value) => user.citizenship = value,
                    validator: (value) =>
                        (!user.firstTry! && value!.isEmpty) ? 'error' : null,
                  ),

                  /// Tourist's passport number
                  CustomTextFormFieldWidget(
                    label: 'Номер загранпаспорта',
                    keyboardType: TextInputType.datetime,
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      PassportInputFormatter(),
                    ],
                    onSubmit: (value) => user.passportNumber = value,
                    validator: (value) =>
                        (user.firstTry! || value!.length == 10)
                            ? null
                            : 'error',
                  ),

                  /// Tourist's passport valid until date
                  CustomTextFormFieldWidget(
                    label: 'Срок действия загранпаспорта',
                    keyboardType: TextInputType.datetime,
                    onSubmit: (value) => user.passportValidUntilDate = value,
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DateInputFormatter(),
                    ],
                    validator: (value) =>
                        (user.firstTry! || value!.isValidDate())
                            ? null
                            : 'error',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
