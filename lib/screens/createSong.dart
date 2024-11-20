// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SongCreationScreen extends StatefulWidget {
//   @override
//   State<SongCreationScreen> createState() => _SongCreationScreenState();
// }

// class _SongCreationScreenState extends State<SongCreationScreen> {
//   final TextEditingController songController = TextEditingController();
//   final FlutterSecureStorage _storage = FlutterSecureStorage();

//   Future<void> _createSong() async {
//     final String songDetails = songController.text;

//     if (songDetails.isEmpty) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please provide the song details')),
//         );
//       }
//       return;
//     }

//     final url = Uri.parse('http://143.244.131.156:8000/create');
//     print(url);

//     String? token = await _storage.read(key: 'jwt_token');
//     print(token);
//     if (token == null) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('User not authenticated')),
//         );
//       }
//       return;
//     }

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token', // Add the JWT token here
//         },
//         body: json.encode({
//           'song': songDetails,
//         }),
//       );
//       print(response.statusCode);

//       if (mounted) {
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           print(data);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Song created successfully')),
//           );
//           print('Song Details: $data');
//           songController.clear();
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to create song')),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.toString()}')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: Color.fromARGB(255, 10, 203, 237),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             'Create Song',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Card(
//                 elevation: 5,
//                 margin: EdgeInsets.only(bottom: 16.0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextField(
//                         controller: songController,
//                         decoration: InputDecoration(labelText: 'Song Details'),
//                         maxLines: 5,
//                       ),
//                       SizedBox(height: 40),
//                       ElevatedButton(
//                         onPressed: _createSong,
//                         child: Text('Create Song'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     songController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SongCreationScreen extends StatefulWidget {
  @override
  State<SongCreationScreen> createState() => _SongCreationScreenState();
}

class _SongCreationScreenState extends State<SongCreationScreen> {
  final TextEditingController songController = TextEditingController();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> _createSong() async {
    final String songDetails = songController.text;

    if (songDetails.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide the song details')),
        );
      }
      return;
    }

    final url = Uri.parse('http://143.244.131.156:8000/create');

    String? token = await _storage.read(key: 'jwt_token');
    if (token == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not authenticated')),
        );
      }
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add the JWT token here
        },
        body: json.encode({
          'song': songDetails,
        }),
      );

      if (mounted) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Song created successfully')),
          );
          songController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create song')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double cardMargin = size.width * 0.05;
    final double padding = size.width * 0.05;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(padding),
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
                            'Create Song',
                            style: TextStyle(
                              fontSize: size.width * 0.06,
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
                margin: EdgeInsets.only(bottom: cardMargin),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: songController,
                        decoration: InputDecoration(
                          labelText: 'Song Details',
                        ),
                        maxLines: 5,
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
                              fontSize: size.width * 0.05,
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
    );
  }

  @override
  void dispose() {
    songController.dispose();
    super.dispose();
  }
}
