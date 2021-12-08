import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  final Geolocator geo = Geolocator();

  Stream getCurrentLocation() {
    return Geolocator.getPositionStream();
  }

  Future getInitialLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
