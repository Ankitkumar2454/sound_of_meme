import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_of_meme/screens/profile_screen.dart';
import 'package:sound_of_meme/screens/createPage.dart';
import 'package:sound_of_meme/screens/customSong_creation_screen.dart';
import 'package:sound_of_meme/screens/userSongPage.dart';
import 'package:sound_of_meme/services/iconBackground.dart';
import 'package:sound_of_meme/screens/song_list_screen.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(1);
  final ValueNotifier<String> pageTitle = ValueNotifier("Songs");
  final pages = [
    CreateScreen(),
    SongListScreen(),
    UserSongsScreen(),
    ProfileScreen(),
  ];
  final titles = const [
    'CreateSongs',
    'Songs',
    'UserSongs',
    'Profile',
  ];
  void handelNavigation(index) {
    setState(() {
      pageIndex.value = index;
      pageTitle.value = titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // surfaceTintColor: Colors.white,
        // foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: Center(
          child: ValueListenableBuilder(
            valueListenable: pageTitle,
            builder: (BuildContext context, String value, _) {
              return Text(
                value,
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 162, 239),
                  fontSize: 30,
                ),
              );
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIndex: handelNavigation,
      ),
    );
  }
}

class BottomNavigationBar extends StatefulWidget {
  ValueChanged<int> selectedIndex;
  BottomNavigationBar({required this.selectedIndex});
  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  int selectedIndex = 1;
  void handelItem(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.selectedIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60, // Increase height

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavigationBarItem(
              index: 0,
              icon: Icons.library_music,
              label: 'Create',
              isSelected: (selectedIndex == 0),
              ontap: handelItem,
            ),
            NavigationBarItem(
              index: 1,
              icon: Icons.music_note,
              label: 'Songs',
              isSelected: (selectedIndex == 1),
              ontap: handelItem,
            ),
            NavigationBarItem(
              index: 2,
              icon: Icons.multitrack_audio_sharp,
              label: 'UserSongs',
              isSelected: (selectedIndex == 2),
              ontap: handelItem,
            ),
            NavigationBarItem(
              index: 3,
              icon: Icons.person,
              label: 'Profile',
              isSelected: (selectedIndex == 3),
              ontap: handelItem,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationBarItem extends StatefulWidget {
  String label;
  IconData icon;
  int index;
  bool isSelected = false;
  ValueChanged<int> ontap;
  NavigationBarItem({
    required this.label,
    required this.icon,
    required this.index,
    required this.ontap,
    required this.isSelected,
  });

  @override
  State<NavigationBarItem> createState() => _NavigationBarItemState();
}

class _NavigationBarItemState extends State<NavigationBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.ontap(widget.index),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected ? Colors.blue : Colors.white,
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              widget.label,
              style: widget.isSelected
                  ? TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)
                  : TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
