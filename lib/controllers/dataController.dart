import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SightingsController extends GetxController {
  @override
  onInit() {
    super.onInit();
  }

  void recordSighting(double lat, double long) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sightings");
    Map<String, dynamic> instance = {
      "time": DateTime.now(),
      "location": GeoPoint(lat, long)
    };
    await reference.add(instance).then((value) => Get.snackbar(
          "Moose sighting recorded",
          "",
          icon: Icon(Icons.check, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack,
        ));
  }
}
