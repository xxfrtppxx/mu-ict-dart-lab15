import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/create_page.dart';
import 'pages/read_page.dart';
import 'pages/update_page.dart';
import 'pages/delete_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album CRUD Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      routes: {
        '/create': (context) => CreateAlbumPage(),
        '/read': (context) => ReadAlbumPage(),
        '/update': (context) => UpdateAlbumPage(),
        '/delete': (context) => DeleteAlbumPage(),
      },
    );
  }
}
