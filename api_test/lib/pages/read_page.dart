import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReadAlbumPage extends StatefulWidget {
  @override
  State<ReadAlbumPage> createState() => _ReadAlbumPageState();
}

class _ReadAlbumPageState extends State<ReadAlbumPage> {
  final TextEditingController _controller = TextEditingController();
  String _rawJson = "";
  String _extractedInfo = "";

  Future<void> _fetchAlbum() async {
    final id = "";
    if (id.isEmpty) return;

    final url = Uri.parse("");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        
      } else {
        setState(() {
          _rawJson = "Error: ${response.statusCode}";
          _extractedInfo = "";
        });
      }
    } catch (e) {
      setState(() {
        _rawJson = "Error: $e";
        _extractedInfo = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Read Album")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter Album ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _fetchAlbum,
              child: Text("Fetch Album"),
            ),
            SizedBox(height: 20),
            Text("🔹 Raw JSON:", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              color: Colors.grey.shade200,
              child: SelectableText(_rawJson),
            ),
            SizedBox(height: 12),
            Text("🔹 Extracted Info:", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              color: Colors.grey.shade100,
              child: SelectableText(_extractedInfo),
            ),
          ],
        ),
      ),
    );
  }
}
