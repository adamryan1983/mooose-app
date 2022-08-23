import 'dart:async';

import 'package:location/location.dart';
import 'package:mooose/models/user_location.dart';

class LocationService {
  //keep track of current location
  late UserLocation _currentLocation;
  Location location = Location();
  //continuously update current location
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if(granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if(locationData != null) {
            _locationController.add(UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude));
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } catch (e) {
      print('coukd not get the location $e');
    }
    return _currentLocation;
  }
}