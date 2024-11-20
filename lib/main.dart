import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_of_meme/screens/profile_screen.dart';
import 'package:sound_of_meme/screens/createSong.dart';
import 'package:sound_of_meme/screens/song_list_screen.dart';
import 'package:sound_of_meme/widgits/theme.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/customSong_creation_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sound of Meme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff062537),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(6, 37, 55, 1),
            iconTheme: IconThemeData(color: Colors.white)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(16, 52, 68, 1),
            selectedItemColor: Color.fromRGBO(27, 163, 147, 1),
            unselectedItemColor: Colors.grey),
        textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)),
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => Consumer<AuthService>(
              builder: (context, auth, _) =>
                  auth.isAuthenticated ? HomeScreen() : LoginScreen(),
            ),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/create': (context) => SongCreationScreen(),
        '/createcustom': (context) => CustomSongCreationScreen(),
        '/songs': (context) => SongListScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
