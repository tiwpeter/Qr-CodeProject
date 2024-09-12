import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  // Method to create a search button
  Widget showSearchButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Show a dialog when the button is pressed
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Search'),
              content: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your search query',
                ),
                onChanged: (value) {
                  // Handle text input here if needed
                },
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                TextButton(
                  child: Text('Search'),
                  onPressed: () {
                    // Handle the search action here
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      },
      icon: Icon(Icons.search), // Search icon
      label: Text('Search'),    // Button label
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Background color of the button
        foregroundColor: Colors.white, // Text color
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Styling the text
      ),
    );
  }

  // Method to show the app name
  Widget showAppName() {
    return Text(
      'Ubg shop',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Optional: Styling the text
    );
  }

  // Method to show category with an image
  Widget showCategory() {
    return Row(
      mainAxisSize: MainAxisSize.min, // Makes Row as small as its children
      children: <Widget>[
        Text(
          'All',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Optional: Styling the text
        ),
        SizedBox(width: 48), // Adds spacing between the text and the image (adjust value as needed)
        Image.asset('assets/images/menu_11.png', width: 24, height: 24), // Custom image
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0), // Optional: Adds padding around the Row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center aligns items horizontally
        children: <Widget>[
          Expanded(child: showAppName()), // Allows the text to take up available space
          SizedBox(width: 10), // Adds spacing between items
          showSearchButton(context), // Pass the context to the method
          SizedBox(width: 10), // Adds spacing between items
          Expanded(child: showCategory()), // Another instance of showAppName
        ],
      ),
    );
  }
}
