import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom text form widget
class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.label,
    this.formatters = const [],
    required this.keyboardType,
    required this.validator,
    required this.onSubmit,
    this.controller,
  });
  final String label;
  final List<TextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final Function(String) onSubmit;
  final TextEditingController? controller;

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  late final TextEditingController _textController =
      widget.controller ?? TextEditingController();

  /// Fill color of a text field
  /// Changes to red if the text is invalid
  Color _textFieldFillColor(String evaluate) {
    bool isValid = widget.validator(evaluate) == null;
    return isValid
        ? Theme.of(context).inputDecorationTheme.fillColor!
        : Theme.of(context).colorScheme.errorContainer;
  }

  /// Disposes controllers when not needed to prevent memory leaks
  @override
  void dispose() {
    // _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _textFieldFillColor(_textController.text),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextFormField(
          controller: _textController,
          keyboardType: widget.keyboardType,
          maxLines: 1,
          inputFormatters: widget.formatters,
          validator: (value) => widget.validator(value),
          onChanged: (value) => widget.onSubmit(value),
          onFieldSubmitted: (value) {
            widget.onSubmit(value);
            setState(() {});
          },
          decoration: InputDecoration(
            fillColor: _textFieldFillColor(_textController.text),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 2.0,
              bottom: 3.0,
            ),
            labelText: widget.label,
          ),
        ),
      ),
    );
  }
}
