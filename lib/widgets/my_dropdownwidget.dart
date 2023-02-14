// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyDropDownWidget<T extends Object> extends StatelessWidget {
  const MyDropDownWidget({
    Key? key,
    this.itemToString,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  final List<T> items;
  final T initialValue;
  final void Function(T?) onChanged;
  final String Function(T)? itemToString;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isDense: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 6,
          ),
        ),
      ),
      value: initialValue,
      items: items
          .map((item) => DropdownMenuItem<T>(
                child: Text(
                  itemToString == null ? '$item' : itemToString!(item),
                  style: Theme.of(context).textTheme.headline6,
                ),
                value: item,
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
