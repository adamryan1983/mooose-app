import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooose/constants/colors.dart';
import 'package:mooose/controllers/mooseSightingsController.dart';

class HomePage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    final MooseSightingsController sight = Get.find();
    // final DataController data = Get.find();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Image.asset('assets/images/moooseheaderlight.png',
            fit: BoxFit.cover, width: 150),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset('assets/images/mooose-logo.png')),
            Text(
              'Sightings in last 24 hours:',
              style: TextStyle(fontSize: 22),
            ),
            Obx(() => Text(
                  "${sight.allSights.length}",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.FOURTH_COLOR),
                )),
          ],
        ),
      ),
    );
  }
}
