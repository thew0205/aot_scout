import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  const MyFormField(
      {Key? key,
      this.initialValue,
      required this.labelText,
      this.errorText,
      required this.onSaved,
      required this.validator,
      bool? autoFocus,
      int? maxlines,
      this.textInputAction,
      this.controller})
      : maxlines = maxlines ?? 1,
        autoFocus = autoFocus ?? false,
        super(key: key);
  final String? initialValue;
  final TextEditingController? controller;
  final String labelText;
  final String? errorText;
  final void Function(String?) onSaved;
  final int maxlines;
  final bool autoFocus;
  final TextInputAction? textInputAction;

  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 8,
        child: TextFormField(
          initialValue: initialValue,
          autofocus: autoFocus,
          minLines: 1,
          maxLines: maxlines,
          textCapitalization: TextCapitalization.sentences,
          controller: controller,
          onSaved: onSaved,
          textInputAction: textInputAction ?? TextInputAction.next,
          validator: validator,
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
      ),
    );
  }
}
