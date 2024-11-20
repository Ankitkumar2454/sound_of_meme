// import 'package:flutter/material.dart';

// class CreateScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           'Select an Option',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2, // Number of columns in the grid
//                 crossAxisSpacing: 10.0, // Horizontal spacing between grid items
//                 mainAxisSpacing: 10.0, // Vertical spacing between grid items
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/create');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Center(child: Text('Create')),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/createcustom');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Center(child: Text('CustomCreate')),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Select an Option',
                    style: TextStyle(
                      fontSize: size.width * 0.05, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Horizontal spacing between grid items
                mainAxisSpacing: 10.0, // Vertical spacing between grid items
                childAspectRatio:
                    size.width / (size.height / 2), // Adjust aspect ratio
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical:
                            size.height * 0.02, // Responsive vertical padding
                        horizontal:
                            size.width * 0.1, // Responsive horizontal padding
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity,
                          size.height * 0.1), // Responsive minimum size
                    ),
                    child: Center(child: Text('Create')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/createcustom');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical:
                            size.height * 0.02, // Responsive vertical padding
                        horizontal:
                            size.width * 0.1, // Responsive horizontal padding
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity,
                          size.height * 0.1), // Responsive minimum size
                    ),
                    child: Center(child: Text('CustomCreate')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
