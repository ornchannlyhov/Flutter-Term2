import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final DateTime initialDate;
  final void Function(DateTime) onDateSelected;

  const DatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  void _showDateSelectionDialog() async {
    final DateTime? result = await Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute(
        DateSelectionScreen(
          initialDate: selectedDate,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
      });
      widget.onDateSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDateSelectionDialog,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: BlaColors.primary, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                DateFormat('EEE, MMM d').format(selectedDate),
                style: BlaTextStyles.body.copyWith(
                  color: BlaColors.textNormal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateSelectionScreen extends StatefulWidget {
  final DateTime initialDate;

  const DateSelectionScreen({
    super.key,
    required this.initialDate,
  });

  @override
  State<DateSelectionScreen> createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white,
      appBar: AppBar(
        backgroundColor: BlaColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: BlaColors.textNormal),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Select Date",
          style: BlaTextStyles.heading.copyWith(color: BlaColors.textNormal),
        ),
      ),
      body: CalendarDatePicker(
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        onDateChanged: (date) {
          Navigator.pop(context, date);
        },
      ),
    );
  }
}
