import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/db.dart';
import 'package:get/get.dart';

class MooseSightingsController extends GetxController {
  // Add a list of Product objects.
  final allSights = <Marker>{}.obs;

  // late final Uint8List markerIcon =

  @override
  void onInit() {
    allSights.bindStream(FirestoreDB().getAllSightings());
    super.onInit();
  }
}
