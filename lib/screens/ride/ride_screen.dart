import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride/widgets/ride_card.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';

class RidesScreen extends StatelessWidget {
  final RidePref ridePref;
  final List<Ride> rides;

  const RidesScreen({
    super.key,
    required this.ridePref,
    required this.rides,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matching Rides",
          style: BlaTextStyles.heading.copyWith(color: BlaColors.neutralDark),
        ),
        backgroundColor: BlaColors.white,
        elevation: 0,
      ),
      backgroundColor: BlaColors.backgroundAccent,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
        itemCount: rides.length,
        itemBuilder: (context, index) {
          final ride = rides[index];
          return RideCard(
            ride: ride,
            onTap: () {
              print(
                  "Selected Ride: ${ride.driver.firstName} ${ride.driver.lastName}");
            },
          );
        },
      ),
    );
  }
}
