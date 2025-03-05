import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repositories/locations/locations_repository.dart';

class LocationsService {
  final LocationsRepository _locationsRepository;

  LocationsService(this._locationsRepository);

  Future<List<Location>> getLocations() async {
    return _locationsRepository.getLocations();
  }
}
