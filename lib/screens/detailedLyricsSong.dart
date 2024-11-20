// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert';

// import 'package:sound_of_meme/modals/song.dart';

// class DetailsLyricsPage extends StatefulWidget {
//   final Song song;
//   final List<Song> songList;
//   final int currentIndex;

//   const DetailsLyricsPage({
//     Key? key,
//     required this.song,
//     required this.songList,
//     required this.currentIndex,
//   }) : super(key: key);

//   @override
//   _DetailsLyricsPageState createState() => _DetailsLyricsPageState();
// }

// class _DetailsLyricsPageState extends State<DetailsLyricsPage> {
//   late AudioPlayer _audioPlayer;
//   late int _currentIndex;
//   late Song _currentSong;
//   bool _isPlaying = false;
//   bool _isLiking = false;
//   final FlutterSecureStorage _storage = FlutterSecureStorage();

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     _currentIndex = widget.currentIndex;
//     _currentSong = widget.songList[_currentIndex];

//     _incrementViewCount(); // Increment view count when the page is loaded

//     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//       if (mounted) {
//         setState(() {
//           _isPlaying = state == PlayerState.playing;
//         });
//       }
//     });
//   }

//   Future<void> _incrementViewCount() async {
//     String? token = await _storage.read(key: 'jwt_token');
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User not authenticated')),
//       );
//       return;
//     }

//     final url = Uri.parse('http://143.244.131.156:8000/view');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: json.encode({
//         'song_id': _currentSong.songId,
//       }),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         _currentSong.views++;
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update view count')),
//       );
//     }
//   }

//   Future<void> _likeSong() async {
//     if (_isLiking) return; // Prevent multiple requests at the same time
//     setState(() {
//       _isLiking = true;
//     });

//     String? token = await _storage.read(key: 'jwt_token');
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User not authenticated')),
//       );
//       setState(() {
//         _isLiking = false;
//       });
//       return;
//     }

//     final url = Uri.parse(_currentSong.isLiked
//         ? 'http://143.244.131.156:8000/dislike'
//         : 'http://143.244.131.156:8000/like');

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: json.encode({
//         'song_id': _currentSong.songId,
//       }),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         if (_currentSong.isLiked) {
//           _currentSong.isLiked = false;
//           _currentSong.likes--;
//         } else {
//           _currentSong.isLiked = true;
//           _currentSong.likes++;
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update like status')),
//       );
//     }

//     setState(() {
//       _isLiking = false;
//     });
//   }

//   void _playPauseSong() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play(UrlSource(_currentSong.songUrl));
//     }
//   }

//   void _nextSong() {
//     if (_currentIndex < widget.songList.length - 1) {
//       setState(() {
//         _currentIndex++;
//         _currentSong = widget.songList[_currentIndex];
//         _playPauseSong();
//       });
//     }
//   }

//   void _previousSong() {
//     if (_currentIndex > 0) {
//       setState(() {
//         _currentIndex--;
//         _currentSong = widget.songList[_currentIndex];
//         _playPauseSong();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_currentSong.songName),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Image.network(
//               _currentSong.imageUrl,
//               height: size.height * 0.4,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         _currentSong.isLiked
//                             ? Icons.thumb_up
//                             : Icons.thumb_up_outlined,
//                         color:
//                             _currentSong.isLiked ? Colors.blue : Colors.white,
//                       ),
//                       onPressed: _likeSong,
//                     ),
//                     Text('Likes: ${_currentSong.likes}'),
//                   ],
//                 ),
//                 Text('Views: ${_currentSong.views}'),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               'Tags: ${_currentSong.tags.join(', ')}',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               _currentSong.songName,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(_currentSong.lyrics),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.skip_previous),
//                 onPressed: _previousSong,
//                 iconSize: 50,
//                 color: Colors.white,
//               ),
//               IconButton(
//                 icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//                 onPressed: _playPauseSong,
//                 iconSize: 50,
//                 color: Colors.white,
//               ),
//               IconButton(
//                 icon: Icon(Icons.skip_next),
//                 onPressed: _nextSong,
//                 iconSize: 50,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:sound_of_meme/modals/song.dart';

class DetailsLyricsPage extends StatefulWidget {
  final Song song;
  final List<Song> songList;
  final int currentIndex;

  const DetailsLyricsPage({
    Key? key,
    required this.song,
    required this.songList,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _DetailsLyricsPageState createState() => _DetailsLyricsPageState();
}

class _DetailsLyricsPageState extends State<DetailsLyricsPage> {
  late AudioPlayer _audioPlayer;
  late int _currentIndex;
  late Song _currentSong;
  bool _isPlaying = false;
  bool _isLiking = false;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.currentIndex;
    _currentSong = widget.songList[_currentIndex];

    _incrementViewCount(); // Increment view count when the page is loaded

    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  Future<void> _incrementViewCount() async {
    String? token = await _storage.read(key: 'jwt_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final url = Uri.parse('http://143.244.131.156:8000/view');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'song_id': _currentSong.songId,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _currentSong.views++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update view count')),
      );
    }
  }

  Future<void> _likeSong() async {
    if (_isLiking) return; // Prevent multiple requests at the same time
    setState(() {
      _isLiking = true;
    });

    String? token = await _storage.read(key: 'jwt_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated')),
      );
      setState(() {
        _isLiking = false;
      });
      return;
    }

    final url = Uri.parse(_currentSong.isLiked
        ? 'http://143.244.131.156:8000/dislike'
        : 'http://143.244.131.156:8000/like');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'song_id': _currentSong.songId,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        if (_currentSong.isLiked) {
          _currentSong.isLiked = false;
          _currentSong.likes--;
        } else {
          _currentSong.isLiked = true;
          _currentSong.likes++;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update like status')),
      );
    }

    setState(() {
      _isLiking = false;
    });
  }

  void _playPauseSong() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(_currentSong.songUrl));
    }
  }

  void _nextSong() {
    if (_currentIndex < widget.songList.length - 1) {
      setState(() {
        _currentIndex++;
        _currentSong = widget.songList[_currentIndex];
        _playPauseSong();
      });
    }
  }

  void _previousSong() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _currentSong = widget.songList[_currentIndex];
        _playPauseSong();
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.023;

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentSong.songName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              _currentSong.imageUrl,
              height: size.height * 0.4,
              width: size.width * 0.7,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _currentSong.isLiked
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        color:
                            _currentSong.isLiked ? Colors.blue : Colors.white,
                      ),
                      onPressed: _likeSong,
                    ),
                    Text('Likes: ${_currentSong.likes}'),
                  ],
                ),
                Text('Views: ${_currentSong.views}'),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              'Tags: ${_currentSong.tags.join(', ')}',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              _currentSong.songName,
              style: TextStyle(
                fontSize: size.height * 0.023,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Text(
                  _currentSong.lyrics,
                  style: TextStyle(fontSize: size.height * 0.02),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: _previousSong,
                  iconSize: size.height * 0.04,
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: _playPauseSong,
                  iconSize: size.height * 0.04,
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: _nextSong,
                  iconSize: size.height * 0.04,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
