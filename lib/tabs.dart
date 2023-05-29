import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mooose/constants/colors.dart';
import 'package:mooose/subpages/map2.dart';
import 'package:mooose/tab_navigation_items.dart';
import 'package:provider/provider.dart';

import './controllers/dataController.dart';
import 'models/user_location.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final SightingsController sights = Get.find();
    var userLocation = Provider.of<UserLocation>(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // This is all you need!
        currentIndex: _currentIndex,
        //look at changing this with get x
        onTap: (int index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.SECONDARY_COLOR,
        unselectedItemColor: AppColors.FOURTH_COLOR,
        selectedItemColor: AppColors.MAINTEXTWHITE,
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              label: tabItem.label,
            ),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.remove,
        buttonSize: Size(60.0,60.0),
        visible: true,
        closeManually: false,

        /// If true overlay will render no matter what.
        renderOverlay: false,
        curve: Curves.elasticIn,
        overlayColor: AppColors.MAINBGBLACK,
        overlayOpacity: 0.5,
        tooltip: 'Popup Menu',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: AppColors.SECONDARY_COLOR,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),

        children: [
          SpeedDialChild(
            child: Icon(Icons.map_outlined),
            backgroundColor: AppColors.FOURTH_COLOR,
            label: 'View Map',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              // Get.to(() => MapDisplay());
              Get.to(() => Map2());
            },
          ),
          // Old way of doing it
          // SpeedDialChild(
          //   child: Icon(Icons.update_outlined),
          //   backgroundColor: AppColors.PRIMARY_COLOR,
          //   label: 'Report Moose Sighting',
          //   labelStyle: TextStyle(fontSize: 18.0),
          //   onTap: () async {
          //     await _getCurrentLocation();
          //     sights.recordSighting(
          //         _currentPosition!.latitude, _currentPosition!.longitude);
          //   },
          // ),
          SpeedDialChild(
            child: Icon(Icons.add_circle_outline_rounded),
            backgroundColor: AppColors.PRIMARY_COLOR,
            label: 'Report Moose Sighting',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              sights.recordSighting(
                  userLocation.latitude!, userLocation.longitude!);
            },
          ),
        ],
      ),
    );
  }
}
