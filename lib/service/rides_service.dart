import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePref preferences) {
    List<Ride> initialResults = availableRides.where((ride) {
      bool departureMatch =
          ride.departureLocation.name == preferences.departure.name &&
              ride.departureLocation.country == preferences.departure.country;
      bool arrivalMatch =
          ride.arrivalLocation.name == preferences.arrival.name &&
              ride.arrivalLocation.country == preferences.arrival.country;
      return departureMatch && arrivalMatch;
    }).toList();
    return initialResults;
  }
}
