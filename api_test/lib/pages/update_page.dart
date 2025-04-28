import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateAlbumPage extends StatefulWidget {
  @override
  State<UpdateAlbumPage> createState() => _UpdateAlbumPageState();
}

class _UpdateAlbumPageState extends State<UpdateAlbumPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  String _responseText = "";

  Future<void> _updateAlbum() async {
    final id = _idController.text.trim();
    final userId = _userIdController.text.trim();
    final title = _titleController.text.trim();

    if (id.isEmpty || userId.isEmpty || title.isEmpty) {
      setState(() {
        _responseText = "❗ Please provide ID, User ID and Title to update";
      });
      return;
    }

    Map<String, dynamic> album = {
      "id": int.parse(id),
      "userId": int.parse(userId),
      "title": title,
    };

    final url = Uri.parse("https://jsonplaceholder.typicode.com/albums/$id");

    String album_json_string = json.encode(album);

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: album_json_string,
      );

      if (response.statusCode == 200) {
        setState(() {
          _responseText = "✅ Updated Album:\n${response.body}";
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
      appBar: AppBar(title: Text("Update Album")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: "Album ID to Update"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: "New User ID"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "New Title"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateAlbum,
              child: Text("Update Album"),
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
