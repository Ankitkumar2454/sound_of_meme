// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sound_of_meme/screens/detailedLyricsSong.dart';
// import '../modals/song.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SongListScreen extends StatefulWidget {
//   @override
//   _SongListScreenState createState() => _SongListScreenState();
// }

// class _SongListScreenState extends State<SongListScreen> {
//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//   int _page = 1;
//   List<Song> _songs = [];
//   List<Song> _filteredSongs = [];
//   bool _isLoading = false;
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchSongs();
//   }

//   Future<void> _fetchSongs() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final url = Uri.parse('http://143.244.131.156:8000/allsongs?page=$_page');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (mounted) {
//         setState(() {
//           _songs.addAll((data['songs'] as List)
//               .map((song) => Song(
//                     songId: song['song_id'],
//                     userId: song['user_id'],
//                     songName: song['song_name'],
//                     songUrl: song['song_url'],
//                     likes: song['likes'],
//                     views: song['views'],
//                     imageUrl: song['image_url'],
//                     lyrics: song['lyrics'],
//                     tags: List<String>.from(song['tags']),
//                     dateTime: DateTime.parse(song['date_time']),
//                   ))
//               .toList());
//           _filteredSongs = List.from(_songs);
//           _page++;
//         });
//       }
//     }

//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _filterSongs(String query) {
//     setState(() {
//       _searchQuery = query;
//       _filteredSongs = _songs
//           .where((song) =>
//               song.songName.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   Future<void> _toggleLike(Song song) async {
//     final token = await _storage.read(key: 'jwt_token');
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User not authenticated')),
//       );
//       return;
//     }

//     final url = Uri.parse(
//         'http://143.244.131.156:8000/${song.isLiked ? 'dislike' : 'like'}');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: json.encode({'song_id': song.songId}),
//     );

//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//       setState(() {
//         if (result['status'] == 'liked') {
//           song.likes++;
//           song.isLiked = true;
//         } else if (result['status'] == 'disliked') {
//           song.likes--;
//           song.isLiked = false;
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to like/dislike song')),
//       );
//     }
//   }

//   void _navigateToDetailsPage(int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DetailsLyricsPage(
//           song: _filteredSongs[index],
//           songList: _filteredSongs,
//           currentIndex: index,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 255, 251, 11),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: _filterSongs,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Search by song name',
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredSongs.length + 1,
//               itemBuilder: (context, index) {
//                 if (index == _filteredSongs.length) {
//                   return _isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : SizedBox.shrink();
//                 }
//                 final song = _filteredSongs[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   elevation: 5,
//                   child: ListTile(
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.network(
//                         song.imageUrl,
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     title: Text(song.songName),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           song.tags.join(', '),
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                         Text('Likes: ${song.likes}'),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(
//                         song.isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
//                         color: song.isLiked ? Colors.blue : Colors.grey,
//                       ),
//                       onPressed: () => _toggleLike(song),
//                     ),
//                     contentPadding: EdgeInsets.all(16),
//                     onTap: () => _navigateToDetailsPage(index),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _fetchSongs,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sound_of_meme/screens/detailedLyricsSong.dart';
import '../modals/song.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SongListScreen extends StatefulWidget {
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  int _page = 1;
  List<Song> _songs = [];
  List<Song> _filteredSongs = [];
  bool _isLoading = false;
  String _searchQuery = '';
  bool _showLikedOnly = false;

  @override
  void initState() {
    super.initState();
    _fetchSongs();
  }

  Future<void> _fetchSongs() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://143.244.131.156:8000/allsongs?page=$_page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          _songs.addAll((data['songs'] as List)
              .map((song) => Song(
                    songId: song['song_id'],
                    userId: song['user_id'],
                    songName: song['song_name'],
                    songUrl: song['song_url'],
                    likes: song['likes'],
                    views: song['views'],
                    imageUrl: song['image_url'],
                    lyrics: song['lyrics'],
                    tags: List<String>.from(song['tags']),
                    dateTime: DateTime.parse(song['date_time']),
                  ))
              .toList());
          _filterSongs(_searchQuery);
          _page++;
        });
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterSongs(String query) {
    setState(() {
      _searchQuery = query;
      _filteredSongs = _songs
          .where((song) =>
              song.songName.toLowerCase().contains(query.toLowerCase()) &&
              (!_showLikedOnly || song.isLiked))
          .toList();
    });
  }

  Future<void> _toggleLike(Song song) async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final url = Uri.parse(
        'http://143.244.131.156:8000/${song.isLiked ? 'dislike' : 'like'}');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'song_id': song.songId}),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        if (result['status'] == 'liked') {
          song.likes++;
          song.isLiked = true;
        } else if (result['status'] == 'disliked') {
          song.likes--;
          song.isLiked = false;
        }
        _filterSongs(_searchQuery);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to like/dislike song')),
      );
    }
  }

  void _navigateToDetailsPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsLyricsPage(
          song: _filteredSongs[index],
          songList: _filteredSongs,
          currentIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: TextField(
              onChanged: _filterSongs,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: 'Search by song name',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Text(
                      'Show liked only',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                  Switch(
                    value: _showLikedOnly,
                    onChanged: (value) {
                      setState(() {
                        _showLikedOnly = value;
                        _filterSongs(_searchQuery);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSongs.length + 1,
              itemBuilder: (context, index) {
                if (index == _filteredSongs.length) {
                  return _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink();
                }
                final song = _filteredSongs[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.02),
                  elevation: 5,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      child: Image.network(
                        song.imageUrl,
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      song.songName,
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.tags.join(', '),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        Text(
                          'Likes: ${song.likes}',
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        song.isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                        color: song.isLiked ? Colors.blue : Colors.grey,
                        size: screenWidth * 0.06,
                      ),
                      onPressed: () => _toggleLike(song),
                    ),
                    contentPadding: EdgeInsets.all(screenWidth * 0.04),
                    onTap: () => _navigateToDetailsPage(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchSongs,
        child: Icon(
          Icons.refresh,
          size: screenWidth * 0.07,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sound_of_meme/screens/detailedLyricsSong.dart';
// import '../modals/song.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SongListScreen extends StatefulWidget {
//   @override
//   _SongListScreenState createState() => _SongListScreenState();
// }

// class _SongListScreenState extends State<SongListScreen> {
//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//   int _page = 1;
//   List<Song> _songs = [];
//   List<Song> _filteredSongs = [];
//   bool _isLoading = false;
//   String _searchQuery = '';
//   bool _showLikedOnly = false; // Added for liked filter

//   @override
//   void initState() {
//     super.initState();
//     _fetchSongs();
//   }

//   Future<void> _fetchSongs() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final url = Uri.parse('http://143.244.131.156:8000/allsongs?page=$_page');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (mounted) {
//         setState(() {
//           _songs.addAll((data['songs'] as List)
//               .map((song) => Song(
//                     songId: song['song_id'],
//                     userId: song['user_id'],
//                     songName: song['song_name'],
//                     songUrl: song['song_url'],
//                     likes: song['likes'],
//                     views: song['views'],
//                     imageUrl: song['image_url'],
//                     lyrics: song['lyrics'],
//                     tags: List<String>.from(song['tags']),
//                     dateTime: DateTime.parse(song['date_time']),
//                   ))
//               .toList());
//           _filterSongs(_searchQuery); // Filter songs after fetching
//           _page++;
//         });
//       }
//     }

//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _filterSongs(String query) {
//     setState(() {
//       _searchQuery = query;
//       _filteredSongs = _songs
//           .where((song) =>
//               song.songName.toLowerCase().contains(query.toLowerCase()) &&
//               (!_showLikedOnly || song.isLiked))
//           .toList();
//     });
//   }

//   Future<void> _toggleLike(Song song) async {
//     final token = await _storage.read(key: 'jwt_token');
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User not authenticated')),
//       );
//       return;
//     }

//     final url = Uri.parse(
//         'http://143.244.131.156:8000/${song.isLiked ? 'dislike' : 'like'}');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: json.encode({'song_id': song.songId}),
//     );

//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//       setState(() {
//         if (result['status'] == 'liked') {
//           song.likes++;
//           song.isLiked = true;
//         } else if (result['status'] == 'disliked') {
//           song.likes--;
//           song.isLiked = false;
//         }
//         _filterSongs(_searchQuery); // Re-filter songs after toggling like
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to like/dislike song')),
//       );
//     }
//   }

//   void _navigateToDetailsPage(int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DetailsLyricsPage(
//           song: _filteredSongs[index],
//           songList: _filteredSongs,
//           currentIndex: index,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: _filterSongs,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.black, // Black border color
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.white, // Black border color when enabled
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.white, // Black border color when focused
//                   ),
//                 ),
//                 hintText: 'Search by song name',
//                 hintStyle: TextStyle(
//                     color: Colors.white // White hint text with opacity
//                     ),
//                 suffixIcon: Icon(
//                   Icons.search,
//                   color: Colors.white, // White color for the search icon
//                 ),
//               ),
//               style: TextStyle(
//                 color: Colors.white, // White color for the input text
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Show liked only',
//                       style: TextStyle(
//                           color: Colors.grey, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Switch(
//                     value: _showLikedOnly,
//                     onChanged: (value) {
//                       setState(() {
//                         _showLikedOnly = value;
//                         _filterSongs(_searchQuery);
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredSongs.length + 1,
//               itemBuilder: (context, index) {
//                 if (index == _filteredSongs.length) {
//                   return _isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : SizedBox.shrink();
//                 }
//                 final song = _filteredSongs[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   elevation: 5,
//                   child: ListTile(
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.network(
//                         song.imageUrl,
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     title: Text(song.songName),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           song.tags.join(', '),
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                         Text('Likes: ${song.likes}'),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(
//                         song.isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
//                         color: song.isLiked ? Colors.blue : Colors.grey,
//                       ),
//                       onPressed: () => _toggleLike(song),
//                     ),
//                     contentPadding: EdgeInsets.all(16),
//                     onTap: () => _navigateToDetailsPage(index),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _fetchSongs,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }
