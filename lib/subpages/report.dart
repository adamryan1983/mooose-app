import 'package:flutter/material.dart';
import 'package:mooose/constants/colors.dart';

class ReportSighting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              'Sightings in last 24hrs:',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              '22',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.FOURTH_COLOR),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add update',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
