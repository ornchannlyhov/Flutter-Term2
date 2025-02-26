import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/app_widget/blabla_button.dart';
import '../../../theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';

class SeatNumberSpinner extends StatefulWidget {
  final int initialValue;
  final Function(int) onChanged;

  const SeatNumberSpinner({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<SeatNumberSpinner> createState() => _SeatNumberSpinnerState();
}

class _SeatNumberSpinnerState extends State<SeatNumberSpinner> {
  late int _selectedSeats;

  @override
  void initState() {
    super.initState();
    _selectedSeats = widget.initialValue;
  }

  void _showSeatPickerDialog() async {
    int tempSeats = _selectedSeats;

    final int? result = await Navigator.push<int>(
      context,
      AnimationUtils.createBottomToTopRoute(
        _SeatPickerDialog(
          initialSeats: tempSeats,
          onSeatsChanged: (newSeats) {
            tempSeats = newSeats;
          },
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedSeats = result;
      });
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showSeatPickerDialog,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(Icons.event_seat, color: BlaColors.primary, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Seat Number",
                style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
              ),
            ),
            Text(
              _selectedSeats.toString(),
              style: BlaTextStyles.heading.copyWith(
                fontSize: 20,
                color: BlaColors.neutralDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeatPickerDialog extends StatefulWidget {
  final int initialSeats;
  final Function(int) onSeatsChanged;

  const _SeatPickerDialog({
    required this.initialSeats,
    required this.onSeatsChanged,
  });

  @override
  State<_SeatPickerDialog> createState() => _SeatPickerDialogState();
}

class _SeatPickerDialogState extends State<_SeatPickerDialog> {
  late int tempSeats;

  @override
  void initState() {
    super.initState();
    tempSeats = widget.initialSeats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: BlaColors.primary),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
        centerTitle: true,
        title: Text(
          "Number of seats to book",
          style: BlaTextStyles.body.copyWith(color: BlaColors.neutralDark, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(color: BlaColors.greyLight, width: 1),
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
                      icon: Icon(
                        Icons.remove,
                        color: tempSeats > 1 ? BlaColors.primary : BlaColors.greyLight,
                        size: 24,
                      ),
                      onPressed: tempSeats > 1
                          ? () {
                              setState(() {
                                tempSeats--;
                                widget.onSeatsChanged(tempSeats);
                              });
                            }
                          : null,
                    ),
                  ),
                  Text(
                    tempSeats.toString(),
                    style: BlaTextStyles.heading.copyWith(color: BlaColors.neutralDark, fontSize: 48),
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(color: BlaColors.primary, width: 1),
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
                      icon: Icon(
                        Icons.add,
                        color: BlaColors.primary,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          tempSeats++;
                          widget.onSeatsChanged(tempSeats);
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: BlaButton(
                  text: "Confirm",
                  onPressed: () {
                    Navigator.pop(context, tempSeats);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}