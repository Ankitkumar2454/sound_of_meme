import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SongDetailScreen extends StatefulWidget {
  final String songId;

  SongDetailScreen({required this.songId});

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  Future<Map<String, dynamic>> _fetchSongDetails() async {
    final url = Uri.parse('http://143.244.131.156:8000/getsongbyid?id=${widget.songId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load song details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchSongDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading song details'));
          } else {
            final song = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${song['song_name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Lyrics: ${song['lyrics']}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Views: ${song['views']}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Likes: ${song['likes']}', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
