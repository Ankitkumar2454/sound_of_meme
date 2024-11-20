// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class CustomSongCreationScreen extends StatefulWidget {
//   @override
//   State<CustomSongCreationScreen> createState() =>
//       _CustomSongCreationScreenState();
// }

// class _CustomSongCreationScreenState extends State<CustomSongCreationScreen> {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController lyricsController = TextEditingController();
//   final TextEditingController genreController = TextEditingController();
//   final FlutterSecureStorage _storage = FlutterSecureStorage();

//   Future<void> _createSong() async {
//     final String title = titleController.text;
//     final String lyrics = lyricsController.text;
//     final String genre = genreController.text;

//     // Check if all fields are filled
//     if (title.isEmpty || lyrics.isEmpty || genre.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill in all fields')),
//       );
//       return;
//     }

//     final url = Uri.parse('http://143.244.131.156:8000/createcustom');

//     // Retrieve the JWT token from secure storage
//     String? token = await _storage.read(key: 'jwt_token');
//     print('JWT Token: $token');

//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User not authenticated')),
//       );
//       return;
//     }

//     // Send POST request to create a custom song
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: json.encode({
//         'title': title,
//         'lyric': lyrics,
//         'genre': genre,
//       }),
//     );

//     print('Response status code: ${response.statusCode}');

//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Song created successfully')),
//       );
//       // Clear the text fields after successful creation
//       titleController.clear();
//       lyricsController.clear();
//       genreController.clear();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to create song')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: Color.fromARGB(255, 10, 203, 237),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Card(
//                   elevation: 4.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Center(
//                             child: Text(
//                               'Create Custom Song',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 Card(
//                   elevation: 5,
//                   margin: EdgeInsets.only(bottom: 16.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextField(
//                           controller: titleController,
//                           decoration: InputDecoration(labelText: 'Song Title'),
//                         ),
//                         SizedBox(height: 20),
//                         TextField(
//                           controller: lyricsController,
//                           decoration: InputDecoration(labelText: 'Lyrics'),
//                           maxLines: 5,
//                         ),
//                         SizedBox(height: 20),
//                         TextField(
//                           controller: genreController,
//                           decoration: InputDecoration(labelText: 'Genre'),
//                         ),
//                         SizedBox(height: 40),
//                         ElevatedButton(
//                           onPressed: _createSong,
//                           child: Text('Create Song'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     lyricsController.dispose();
//     genreController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomSongCreationScreen extends StatefulWidget {
  @override
  State<CustomSongCreationScreen> createState() =>
      _CustomSongCreationScreenState();
}

class _CustomSongCreationScreenState extends State<CustomSongCreationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController lyricsController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> _createSong() async {
    final String title = titleController.text;
    final String lyrics = lyricsController.text;
    final String genre = genreController.text;

    // Check if all fields are filled
    if (title.isEmpty || lyrics.isEmpty || genre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final url = Uri.parse('http://143.244.131.156:8000/createcustom');

    // Retrieve the JWT token from secure storage
    String? token = await _storage.read(key: 'jwt_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    // Send POST request to create a custom song
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'title': title,
        'lyric': lyrics,
        'genre': genre,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Song created successfully')),
      );
      // Clear the text fields after successful creation
      titleController.clear();
      lyricsController.clear();
      genreController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create song')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = size.width * 0.05;
    final double fontSize = size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Create Custom Song',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.only(bottom: padding),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: 'Song Title',
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextField(
                          controller: lyricsController,
                          decoration: InputDecoration(
                            labelText: 'Lyrics',
                          ),
                          maxLines: 5,
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextField(
                          controller: genreController,
                          decoration: InputDecoration(
                            labelText: 'Genre',
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _createSong,
                            child: Text('Create Song'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                              ),
                              textStyle: TextStyle(
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    lyricsController.dispose();
    genreController.dispose();
    super.dispose();
  }
}
