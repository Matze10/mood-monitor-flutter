import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A reusable row widget for displaying and picking a date.
/// Shows the current selected date and a calendar icon button.
/// When the icon is pressed, a date picker dialog appears.
/// Calls [onDateChanged] when a new date is picked.
class DatePickerRow extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerRow({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('yyyy-MM-dd').format(selectedDate),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null && picked != selectedDate) {
              onDateChanged(picked);
            }
          },
        ),
      ],
    );
  }
}
