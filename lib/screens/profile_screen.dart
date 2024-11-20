// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/auth_service.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserDetails();
//   }

//   Future<void> _fetchUserDetails() async {
//     try {
//       final authService = Provider.of<AuthService>(context, listen: false);
//       await authService.fetchUserDetails();
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = 'Failed to load user details';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final authService = Provider.of<AuthService>(context);
//     if (_isLoading) {
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.blueGrey,
//                     radius: 60,
//                     backgroundImage: authService.user?.profileUrl != null &&
//                             authService.user!.profileUrl!.isNotEmpty
//                         ? NetworkImage(authService.user!.profileUrl!)
//                         : NetworkImage(
//                             "https://soundofmeme.s3.amazonaws.com/9f6db221-286c-4e13-aef9-7b8dc6547d40.jpeg"),
//                   ),
//                   SizedBox(width: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Name: ${authService.user?.name}',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 1.1,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Email: ${authService.user?.email}',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.normal,
//                           color: Colors.white,
//                           letterSpacing: 1.0,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 20),
// Card(
//   margin: EdgeInsets.zero,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(8),
//   ),
//   color:
//       Color.fromARGB(131, 180, 108, 108).withOpacity(0.5),
//   elevation: 0,
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//     child: Container(
//       height: 45,
//       child: Center(
//         child: Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ),
//   ),
// )
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               if (_errorMessage != null)
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: Text(
//                     _errorMessage!,
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.2,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               if (_errorMessage == null) ...[
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.teal,
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       textStyle: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     onPressed: () async {
//                       await authService.logout();
//                       Navigator.pushReplacementNamed(context, '/login');
//                     },
//                     child: Text('Logout'),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.fetchUserDetails();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load user details';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      // backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        // Added scrollable container
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04), // Responsive padding
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: size.width * 0.15, // Responsive radius
                    backgroundImage: authService.user?.profileUrl != null &&
                            authService.user!.profileUrl!.isNotEmpty
                        ? NetworkImage(authService.user!.profileUrl!)
                        : NetworkImage(
                            "https://soundofmeme.s3.amazonaws.com/9f6db221-286c-4e13-aef9-7b8dc6547d40.jpeg"),
                  ),
                  SizedBox(width: size.width * 0.05), // Responsive spacing
                  Flexible(
                    // Ensure content does not overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${authService.user?.name}',
                          style: TextStyle(
                            fontSize: size.width * 0.05, // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                            height: size.height * 0.01), // Responsive spacing
                        Text(
                          'Email: ${authService.user?.email}',
                          style: TextStyle(
                            fontSize: size.width * 0.04, // Responsive font size
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.height * 0.02),

                        Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Color.fromARGB(131, 180, 108, 108)
                              .withOpacity(0.5),
                          elevation: 0,
                          child: SizedBox(
                            width: size.width * 0.8, // Responsive width
                            height: size.height * 0.06, // Responsive height
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // primary: Colors.teal,
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.015),
                                textStyle: TextStyle(
                                  fontSize:
                                      size.width * 0.04, // Responsive font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                // Handle edit profile action
                                // Navigator.pushNamed(context, '/edit-profile');
                              },
                              child: Center(child: Text('Edit Profile')),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03), // Responsive spacing
              if (_errorMessage != null)
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02), // Responsive padding
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: size.width * 0.05, // Responsive font size
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (_errorMessage == null) ...[
                SizedBox(height: size.height * 0.03), // Responsive spacing
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SizedBox(
                    width: size.width * 0.8, // Responsive width
                    height: size.height * 0.06, // Responsive height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.015),
                        textStyle: TextStyle(
                          fontSize: size.width * 0.04, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        await authService.logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Center(child: Text('Logout')),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
