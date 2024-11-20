import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSongsScreen extends StatefulWidget {
  @override
  State<UserSongsScreen> createState() => _UserSongsScreenState();
}

class _UserSongsScreenState extends State<UserSongsScreen> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  int _currentPage = 1;
  bool _isLoading = false;
  List<dynamic> _songs = [];

  @override
  void initState() {
    super.initState();
    _fetchUserSongs();
  }

  Future<void> _fetchUserSongs() async {
    setState(() {
      _isLoading = true;
    });

    String? token = await _storage.read(key: 'jwt_token');
    print(token);

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url =
        Uri.parse('http://143.244.131.156:8000/usersongs?page=$_currentPage');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        if (data['songs'].isNotEmpty) {
          _songs.addAll(data['songs']);
        } else if (_songs.isEmpty) {
          _songs = [
            {
              'song_name': 'Dummy Song 1',
              'image_url':
                  "https://soundofmeme.s3.amazonaws.com/7a891971-fd74-4eee-8aae-937d77340e0b.jpeg",
              'likes': 2,
              'views': 34,
            },
            {
              'song_name': 'Dummy Song 2',
              'image_url':
                  "https://soundofmeme.s3.amazonaws.com/564cd8c6-99fc-4425-b42f-5a4b67f67a6a.jpeg",
              'likes': 15,
              'views': 20,
            },
            {
              'song_name': 'Dummy Song 3',
              'image_url':
                  "https://soundofmeme.s3.amazonaws.com/71d129c7-00e3-4b2d-9233-d8890cc437df.jpeg",
              'likes': 1,
              'views': 5,
            },
          ];
        }
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch songs')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double imageSize = size.width * 0.13;
    double buttonHeight = size.height * 0.06;

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: padding),
              itemCount: _songs.length + 1,
              itemBuilder: (context, index) {
                if (index == _songs.length) {
                  return _currentPage > 1
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentPage++;
                              });
                              _fetchUserSongs();
                            },
                            child: Text('Load More'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, buttonHeight),
                              textStyle: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                }

                final song = _songs[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Image.network(
                        song['image_url'],
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      song['song_name'],
                      style: TextStyle(fontSize: size.width * 0.04),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Likes: ${song['likes']}',
                          style: TextStyle(fontSize: size.width * 0.035),
                        ),
                        Text(
                          'Views: ${song['views']}',
                          style: TextStyle(fontSize: size.width * 0.035),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle song tap if needed
                    },
                  ),
                );
              },
            ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class UserSongsScreen extends StatefulWidget {
//   @override
//   State<UserSongsScreen> createState() => _UserSongsScreenState();
// }

// class _UserSongsScreenState extends State<UserSongsScreen> {
//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//   int _currentPage = 1;
//   bool _isLoading = false;
//   List<dynamic> _songs = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserSongs();
//   }

//   Future<void> _fetchUserSongs() async {
//     setState(() {
//       _isLoading = true;
//     });

//     String? token = await _storage.read(key: 'jwt_token');
//     print(token);

//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User not authenticated')),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }

//     final url =
//         Uri.parse('http://143.244.131.156:8000/usersongs?page=$_currentPage');

//     final response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     print(response.statusCode);

//     //   if (response.statusCode == 200) {
//     //     final data = json.decode(response.body);
//     //     print(data);
//     //     setState(() {
//     //       _songs.addAll(data['songs']);
//     //       _isLoading = false;
//     //     });
//     //   } else {
//     //     ScaffoldMessenger.of(context).showSnackBar(
//     //       SnackBar(content: Text('Failed to fetch songs')),
//     //     );
//     //     setState(() {
//     //       _isLoading = false;
//     //     });
//     //   }
//     // }
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       print(data);
//       setState(() {
//         if (data['songs'].isNotEmpty) {
//           _songs.addAll(data['songs']);
//         } else if (_songs.isEmpty) {
//           // Create 2-3 dummy songs if no songs are fetched
//           _songs = [
//             {
//               'song_name': 'Dummy Song 1',
//               'image_url':
//                   "https://soundofmeme.s3.amazonaws.com/7a891971-fd74-4eee-8aae-937d77340e0b.jpeg",
//               'likes': 2,
//               'views': 34,
//             },
//             {
//               'song_name': 'Dummy Song 2',
//               'image_url':
//                   "https://soundofmeme.s3.amazonaws.com/564cd8c6-99fc-4425-b42f-5a4b67f67a6a.jpeg",
//               'likes': 15,
//               'views': 20,
//             },
//             {
//               'song_name': 'Dummy Song 3',
//               'image_url':
//                   "https://soundofmeme.s3.amazonaws.com/71d129c7-00e3-4b2d-9233-d8890cc437df.jpeg",
//               'likes': 1,
//               'views': 5,
//             },
//           ];
//         }
//         _isLoading = false;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch songs')),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _songs.length + 1,
//               itemBuilder: (context, index) {
//                 if (index == _songs.length) {
//                   return _currentPage > 1
//                       ? ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _currentPage++;
//                             });
//                             _fetchUserSongs();
//                           },
//                           child: Text('Load More'),
//                         )
//                       : Container();
//                 }

//                 final song = _songs[index];

//                 return Card(
//                     margin:
//                         EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: ListTile(
//                       leading: ClipRRect(
//                         child: Image.network(
//                           song['image_url'],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(song['song_name']),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Likes: ${song['likes']}'),
//                           Text('Views: ${song['views']}'),
//                         ],
//                       ),
//                       onTap: () {
//                         // Handle song tap if needed
//                       },
//                     ));
//               },
//             ),
//     );
//   }
// }
