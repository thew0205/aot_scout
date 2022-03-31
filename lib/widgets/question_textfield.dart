import 'package:flutter/material.dart';
import 'package:aot_scout/utilities/typedefs.dart';

class QuestionTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final StringCallback onPressed;
  final String? errorText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String labelText;
  final bool? enabled;
  const QuestionTextField({
    Key? key,
    required this.controller,
    required this.focus,
    required this.onPressed,
    required this.errorText,
    this.textInputAction,
    this.keyboardType,
    required this.labelText,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        enabled: enabled,
        autofocus: true,
        onSubmitted: onPressed,
        focusNode: focus,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          errorText: errorText,
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 6,
            ),
          ),
        ),
      ),
    );
  }
}
