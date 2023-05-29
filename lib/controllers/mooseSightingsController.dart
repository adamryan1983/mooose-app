import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/marked_sighting.dart';
import '../services/db.dart';

class MooseSightingsController extends GetxController {
  // Add a list of Product objects.
  final allSights = <Marker>{}.obs;
  final allSightPositions = <MarkedSighting>{}.obs;

  @override
  void onInit() {
    allSights.bindStream(FirestoreDB().getAllSightings());
    allSightPositions.bindStream(FirestoreDB().getAllSightPositions());
    super.onInit();
  }
}
