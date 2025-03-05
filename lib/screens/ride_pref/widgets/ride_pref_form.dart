import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride/ride_screen.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/app_widgets/blabla_button.dart';
import 'package:week_3_blabla_project/app_widgets/location_picker.dart';
import 'package:week_3_blabla_project/app_widgets/date_picker.dart';
import 'package:week_3_blabla_project/app_widgets/seat_number_spinner.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  late DateTime departureDate;
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

  void _onSearchPressed() async {
    if (departure != null && arrival != null) {
      RidePref ridePref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );

      RidesFilter ridesFilter =
          RidesFilter(petAccepted: true); 

      try {
        List<Ride> filteredRides =
            await RidesService.instance.getRides(ridePref, ridesFilter);

        if (!mounted) return; 

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RidesScreen(
              ridePref: ridePref,
              rides: filteredRides,
            ),
          ),
        );
      } catch (e) {
        print(
            "Error fetching rides: $e"); 
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(BlaSpacings.m),
          margin: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  LocationPicker(
                    label: "Departure",
                    initialLocation: departure,
                    onLocationSelected: _updateDeparture,
                  ),
                  IconButton(
                    icon: Icon(Icons.swap_vert, color: BlaColors.primary),
                    onPressed: _switchLocations,
                  ),
                ],
              ),
              Divider(color: BlaColors.greyLight, thickness: 1),
              LocationPicker(
                label: "Arrival",
                initialLocation: arrival,
                onLocationSelected: _updateArrival,
              ),
              Divider(color: BlaColors.greyLight, thickness: 1),
              DatePicker(
                initialDate: departureDate,
                onDateSelected: _updateDepartureDate,
              ),
              Divider(color: BlaColors.greyLight, thickness: 1),
              SeatNumberSpinner(
                initialValue: requestedSeats,
                onChanged: _updateSeats,
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
            child: BlaButton(
              text: "Search",
              onPressed: _onSearchPressed,
              isPrimary: true,
              icon: Icons.search,
            ),
          ),
        ),
      ],
    );
  }
}
