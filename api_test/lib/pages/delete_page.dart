import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteAlbumPage extends StatefulWidget {
  @override
  State<DeleteAlbumPage> createState() => _DeleteAlbumPageState();
}

class _DeleteAlbumPageState extends State<DeleteAlbumPage> {
  final TextEditingController _idController = TextEditingController();
  String _responseText = "";

  Future<void> _deleteAlbum() async {
    //Task07
    final id = _idController.text.trim();

    if (id.isEmpty) {
      setState(() {
        _responseText = "❗ Please provide ID to delete";
      });
      return;
    }

    final url = Uri.parse("https://jsonplaceholder.typicode.com/albums/$id");

    try {
      final response = await http.delete(
        //Task08
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          _responseText = "✅ Delete ID $id successfully";
        });
      } else {
        setState(() {
          _responseText = "❌ Error : ${response.statusCode}";
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
      appBar: AppBar(title: Text("Delete Album")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: "Album ID to delete",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _deleteAlbum,
              child: Text("Delete Album"),
            ),
            SizedBox(height: 20),
            Text("ผลลัพธ์:", style: TextStyle(fontWeight: FontWeight.bold)),
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
