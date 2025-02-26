import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/screens/app_widget/blabla_button.dart';
import 'package:week_3_blabla_project/screens/app_widget/location_picker.dart';
import 'package:week_3_blabla_project/screens/app_widget/date_picker.dart';
import 'package:week_3_blabla_project/screens/app_widget/seat_number_spinner.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  void _updateDeparture(Location newLocation) {
    setState(() {
      departure = newLocation;
    });
  }

  void _updateArrival(Location newLocation) {
    setState(() {
      arrival = newLocation;
    });
  }

  void _updateDepartureDate(DateTime newDate) {
    setState(() {
      departureDate = newDate;
    });
  }

  void _updateSeats(int newSeats) {
    setState(() {
      requestedSeats = newSeats;
    });
  }

  void _switchLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  void _onSearchPressed() {
    if (departure != null && arrival != null) {
      RidePref ridePref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );

      Navigator.pop(context, ridePref);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LocationPicker(
          label: "Departure",
          initialLocation: departure,
          onLocationSelected: _updateDeparture,
        ),
        IconButton(
          icon: Icon(Icons.swap_vert),
          onPressed: _switchLocations,
        ),
        LocationPicker(
          label: "Arrival",
          initialLocation: arrival,
          onLocationSelected: _updateArrival,
        ),
        DatePicker(
          initialDate: departureDate,
          onDateSelected: _updateDepartureDate,
        ),
        SeatNumberSpinner(
          initialValue: requestedSeats,
          onChanged: _updateSeats,
        ),
        BlaButton(
          text: "Search",
          onPressed: _onSearchPressed,
          isPrimary: true,
          icon: Icons.search,
        ),
      ],
    );
  }
}
