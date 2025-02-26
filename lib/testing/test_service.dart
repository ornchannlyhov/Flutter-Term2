import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:intl/intl.dart';

void main() {
  // Get today's date 
  DateTime today = DateTime.now();
  String todayFormatted = DateFormat('yyyy-MM-dd').format(today);

  // Filter rides for Today
  List<Ride> todaysRides = RidesService.availableRides.where((ride) {
    String rideDate = DateFormat('yyyy-MM-dd').format(ride.departureDate);
    return rideDate == todayFormatted;
  }).toList();

  // Display test results
  print("\n=== Available Rides Today ($todayFormatted) ===");

  if (todaysRides.isEmpty) {
    print("No rides available today.");
  } else {
    for (final ride in todaysRides) {
      print("🛣 From: ${ride.departureLocation.name} → To: ${ride.arrivalLocation.name}");
      print("📅 Departure: ${ride.departureDate}");
      print("👤 Driver: ${ride.driver.firstName} ${ride.driver.lastName}");
      print("💺 Available Seats: ${ride.availableSeats}");
      print("💰 Price per Seat: ${ride.pricePerSeat}€");
      print("--------------------------------------------------");
    }
  }
}
