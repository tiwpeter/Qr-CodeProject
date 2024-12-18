import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFC7253E), // ตั้งค่าสีพื้นหลังของ AppBar เป็นสีแดง
      title: Text(
        'LogInput',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // ตั้งค่าสีข้อความเป็นสีขาว
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white), // ตั้งค่าสีของไอคอนเป็นสีขาว
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Search'),
                  content: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your search query',
                      hintStyle: TextStyle(color: Colors.black), // ตั้งค่าสีของข้อความ placeholder
                    ),
                    onChanged: (value) {
                      // Handle text input here if needed
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel', style: TextStyle(color: Colors.red)), // ตั้งค่าสีข้อความเป็นสีแดง
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Search', style: TextStyle(color: Colors.red)), // ตั้งค่าสีข้อความเป็นสีแดง
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // ตั้งค่าสีข้อความเป็นสีขาว
            ),
            SizedBox(width: 8),
            Image.asset('assets/images/menu_11.png', width: 24, height: 24), // ปรับขนาดของภาพ
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
