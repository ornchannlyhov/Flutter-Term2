import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/user/user.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'rides_repository.dart';

class MockRidesRepository implements RidesRepository {
  @override
  Future<List<Ride>> getRides(RidePref preference, RidesFilter? filter) async {

    List<Ride> rides = [
      Ride(
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
        arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
        arrivalDateTime: DateTime.now().add(Duration(hours: 7, minutes: 30)),
        driver: User(
            firstName: 'Kannika',
            lastName: 'Test',
            email: 'test',
            phone: 'test',
            profilePicture: 'test',
            verifiedProfile: true),
        availableSeats: 2,
        pricePerSeat: 5.0,
        acceptPets: false, // Set the pet acceptance for each ride
      ),
      Ride(
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 20)),
        arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
        arrivalDateTime: DateTime.now().add(Duration(hours: 22)),
        driver: User(
            firstName: 'Chaylim',
            lastName: 'Test',
            email: 'test',
            phone: 'test',
            profilePicture: 'test',
            verifiedProfile: true),
        availableSeats: 0,
        pricePerSeat: 6.0,
        acceptPets: false,
      ),
      Ride(
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 5)),
        arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
        driver: User(
            firstName: 'Mengtech',
            lastName: 'Test',
            email: 'test',
            phone: 'test',
            profilePicture: 'test',
            verifiedProfile: true),
        availableSeats: 1,
        pricePerSeat: 7.0,
        acceptPets: true, //Pet accepted
      ),
      Ride(
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 20)),
        arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
        arrivalDateTime: DateTime.now().add(Duration(hours: 22)),
        driver: User(
            firstName: 'Limhao',
            lastName: 'Test',
            email: 'test',
            phone: 'test',
            profilePicture: 'test',
            verifiedProfile: true),
        availableSeats: 2,
        pricePerSeat: 8.0,
        acceptPets: true, //Pet accepted
      ),
      Ride(
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime.now().add(Duration(hours: 5)),
        arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
        arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
        driver: User(
            firstName: 'Sovanda',
            lastName: 'Test',
            email: 'test',
            phone: 'test',
            profilePicture: 'test',
            verifiedProfile: true),
        availableSeats: 1,
        pricePerSeat: 9.0,
        acceptPets: false,
      ),
    ];

    // Apply filtering based on preference
    rides = rides.where((ride) {
      bool departureMatch =
          ride.departureLocation.name == preference.departure.name &&
              ride.departureLocation.country == preference.departure.country;
      bool arrivalMatch =
          ride.arrivalLocation.name == preference.arrival.name &&
              ride.arrivalLocation.country == preference.arrival.country;
      return departureMatch && arrivalMatch;
    }).toList();

    // Apply the filter
    if (filter != null) {
      rides =
          rides.where((ride) => ride.acceptPets == filter.petAccepted).toList();
    }

    return rides;
  }
}
