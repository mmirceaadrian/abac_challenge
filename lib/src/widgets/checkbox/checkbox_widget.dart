import 'package:flutter/material.dart';

/// Widget for the checkbox
///
/// This widget is used to create a checkbox with a title.
class CheckBoxWidget extends StatelessWidget {
  final String? title;
  final bool? value;
  final Function(bool?) onChanged;

  const CheckBoxWidget({
    Key? key,
    this.title,
    this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 30),
          child: CheckboxListTile(
            value: value,
            onChanged: (newValue) {
              onChanged(newValue);
            },
          ),
        ),
        Text(
          title!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
