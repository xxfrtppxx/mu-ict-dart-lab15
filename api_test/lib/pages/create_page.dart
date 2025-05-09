import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateAlbumPage extends StatefulWidget {
  @override
  State<CreateAlbumPage> createState() => _CreateAlbumPageState();
}

class _CreateAlbumPageState extends State<CreateAlbumPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  String _responseText = "";

  Future<void> _createAlbum() async {
    final id = _idController.text.trim();
    final userId = _userIdController.text.trim();
    final title = _titleController.text.trim();

    if (id.isEmpty || userId.isEmpty || title.isEmpty) {
      setState(() {
        _responseText = "❗ All fields are required.";
      });
      return;
    }

    final url = Uri.parse("https://jsonplaceholder.typicode.com/albums");

    Map<String, dynamic> album = {
      "id": int.parse(id),
      "userId": int.parse(userId),
      "title": title,
    };

    String album_json_string = json.encode(album);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: album_json_string,
      );

      if (response.statusCode == 201) {
        setState(() {
          _responseText = "✅ Created Album:\n${response.body}";
        });
      } else {
        setState(() {
          _responseText = "❌ Error: ${response.statusCode}\n${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _responseText = "❌ Exception: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Album")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: "Album ID"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: "User ID"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createAlbum,
              child: Text("Create Album"),
            ),
            SizedBox(height: 20),
            Text("Response:", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colors.grey.shade100,
              child: SelectableText(_responseText),
            ),
          ],
        ),
      ),
    );
  }
}
