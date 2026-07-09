import 'trekking_location.dart';

abstract class ITrekkingRepository {
  Future<List<TrekkingLocation>> getLocations();
}
