import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../utils/date_time_util.dart';
import '../../../theme/theme.dart';

class RideCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback onTap;

  const RideCard({
    super.key,
    required this.ride,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: BlaSpacings.s,
        horizontal: BlaSpacings.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
        child: Padding(
          padding: const EdgeInsets.all(BlaSpacings.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Departure and Arrival Times
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateTimeUtils.formatTime(ride.departureDate),
                    style: BlaTextStyles.heading.copyWith(
                      fontSize: 18,
                      color: BlaColors.neutralDark,
                    ),
                  ),
                  Text(
                    DateTimeUtils.formatTime(ride.arrivalDateTime),
                    style: BlaTextStyles.heading.copyWith(
                      fontSize: 18,
                      color: BlaColors.neutralDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: BlaSpacings.s),
              // Locations and Duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ride.departureLocation.name,
                    style: BlaTextStyles.body.copyWith(
                      color: BlaColors.neutralDark,
                    ),
                  ),
                  Text(
                    DateTimeUtils.calculateDuration(ride.departureDate, ride.arrivalDateTime),
                    style: BlaTextStyles.body.copyWith(
                      color: BlaColors.neutralLight,
                    ),
                  ),
                  Text(
                    ride.arrivalLocation.name,
                    style: BlaTextStyles.body.copyWith(
                      color: BlaColors.neutralDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: BlaSpacings.m),
              // Price
              Text(
                "\$${ride.pricePerSeat.toStringAsFixed(2)}",
                style: BlaTextStyles.heading.copyWith(
                  fontSize: 24,
                  color: BlaColors.primary,
                ),
              ),
              SizedBox(height: BlaSpacings.s),
              // Driver Information
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(ride.driver.profilePicture),
                    radius: 20,
                  ),
                  SizedBox(width: BlaSpacings.s),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${ride.driver.firstName} ${ride.driver.lastName}",
                        style: BlaTextStyles.body.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BlaColors.neutralDark,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: BlaColors.primary,
                          ),
                          SizedBox(width: BlaSpacings.s / 2),
                          Text(
                            "4.8", // dummy rating 
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.neutralDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
