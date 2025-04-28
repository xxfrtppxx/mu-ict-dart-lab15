
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album CRUD Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/create'),
              child: Text("Create Album"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/read'),
              child: Text("Read Albums"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/update'),
              child: Text("Update Album"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/delete'),
              child: Text("Delete Album"),
            ),
          ],
        ),
      ),
    );
  }
}
