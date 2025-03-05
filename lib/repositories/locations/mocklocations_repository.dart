import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repositories/locations/locations_repository.dart';

class MockLocationsRepository implements LocationsRepository {
  @override
  Future<List<Location>> getLocations() async {
    return [
      Location(name: 'Phnom Penh', country: Country.cambodia),
      Location(name: 'Siem Reap', country: Country.cambodia),
      Location(name: 'Battambang', country: Country.cambodia),
      Location(name: 'Sihanoukville', country: Country.cambodia),
      Location(name: 'Kampot', country: Country.cambodia),
    ];
  }
}