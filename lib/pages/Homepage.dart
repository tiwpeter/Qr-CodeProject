import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  // Method to show the app name
  Widget showAppName() {
    return Text(
      'Ubg shop',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Optional: Styling the text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter, // Aligns the Row to the top center of the screen
          child: Container(
            padding: EdgeInsets.all(16.0), // Optional: Adds padding around the Row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center aligns items horizontally
              children: <Widget>[
                Expanded(child: showAppName()), // Allows the text to take up available space
                SizedBox(width: 10), // Adds spacing between texts
                Expanded(child: showAppName()), // Another instance of showAppName
                SizedBox(width: 10), // Adds spacing between texts
                Expanded(child: showAppName()), // Another instance of showAppName
              ],
            ),
          ),
        ),
      ),
    );
  }
}
