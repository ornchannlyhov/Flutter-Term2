import 'package:week_3_blabla_project/model/ride/locations.dart';

abstract class LocationsRepository {
  Future<List<Location>> getLocations();
  
}


