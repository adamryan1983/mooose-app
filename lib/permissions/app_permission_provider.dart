import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

enum AppPermissions {
  granted,
  denied,
  restricted,
  permanentlyDenied,
}


class AppPermissionProvider with ChangeNotifier {
  // Start with default permission status i.e denied
// #1
  PermissionStatus _locationStatus = PermissionStatus.denied;

  // Getter
// #2
  get locationStatus => _locationStatus;

// # 3
  Future<PermissionStatus> getLocationStatus() async {
    // Request for permission
    // #4
     final status = await Permission.location.request();
    // change the location status
   // #5
    _locationStatus = status;
    print(_locationStatus);
    // notify listeners
    notifyListeners();
    return status;

  }
}
