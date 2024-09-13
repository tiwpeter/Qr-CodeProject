import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Ubg shop',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
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
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Search'),
                      onPressed: () {
                        // Handle the search action here
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        SizedBox(width: 10),
        Row(
          children: [
            Text(
              'All',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Image.asset('assets/images/menu_11.png', width: 24, height: 24),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
