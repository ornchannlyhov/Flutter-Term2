import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repositories/rides/rides_repository.dart';
import '../model/ride/ride.dart';

class RidesFilter {
  final bool petAccepted;

  RidesFilter({required this.petAccepted});
}

///   This service handles:
///   - The list of available rides
class RidesService {
  static RidesService? _instance;
  late final RidesRepository _ridesRepository;

  RidesService._internal(RidesRepository ridesRepository)
      : _ridesRepository = ridesRepository;

  // Singleton accessor
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          'RidesService has not been initialized.  Call RidesService.initialize() first.');
    }
    return _instance!;
  }

  // Initialization method
  static void initialize(RidesRepository ridesRepository) {
    _instance = RidesService._internal(ridesRepository);
  }

  // Updated API method
  Future<List<Ride>> getRides(RidePref preference, RidesFilter? filter) async {
    return _ridesRepository.getRides(preference, filter);
  }
}
