import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_of_meme/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late AuthService authService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtain the AuthService instance here
    authService = Provider.of<AuthService>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Center(
                    child: Container(
                      height: size.height * 0.12,
                      width: size.width * 0.30,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.043,
                  ),
                  Container(
                    height: size.height * 0.034,
                    width: size.height * 0.23,
                    child: const Text(
                      "Welcome, Back",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.055,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          } else if (!EmailValidator.validate(
                              emailController.text.trim())) {
                            return "Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: size.height * 0.020,
                              width: size.width * 0.020,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Icon(
                                  Icons.mail,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          hintText: "Email",
                          hintStyle: const TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.031,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: size.height * 0.020,
                              width: size.width * 0.020,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Icon(
                                  Icons.lock,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                              icon: _secureText
                                  ? const Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Color(0xffFFFFFF),
                                    )
                                  : const Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Color(0xffFFFFFF),
                                    )),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Container(
                        height: size.height * 0.021,
                        width: size.width * 0.30,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF),
                              fontFamily: "Google Sans"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.029,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formkey.currentState!.validate()) {
                        try {
                          await authService.login(
                            emailController.text,
                            passwordController.text,
                          );
                          // Navigator.pushReplacementNamed(context, '/home');
                          // Delay the navigation to avoid accessing a deactivated widget
                          Future.microtask(() {
                            Navigator.pushReplacementNamed(context, '/home');
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Failed')),
                          );
                        }
                      }
                    },
                    child: Center(
                      child: Container(
                        height: size.height * 0.065,
                        width: size.width * 0.81,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(96),
                          color: Color(0xff21C4A7),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.045,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.36),
                        child: Container(
                          height: size.height * 0.021,
                          width: size.width * 0.036,
                          child: const Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.026,
                  ),
                  Center(
                    child: Container(
                      height: size.height * 0.031,
                      width: size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.025,
                            width: size.width * 0.45,
                            child: const Text(
                              "Don’t have an account ?",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 15,
                                fontFamily: 'Google Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/signup'),
                            child: Container(
                              height: size.height * 0.028,
                              width: size.width * 0.189,
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xffFFFFFF),
                                  fontSize: 16,
                                  fontFamily: 'Google Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text("Designed and developed by @Ankit")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






















// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sound_of_meme/services/auth_service.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool _secureText = true;
//   GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);

//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     // height: 55,
//                     height: size.height * 0.05,
//                   ),

//                   Center(
//                     child: Container(
//                       height: size.height * 0.12,
//                       width: size.width * 0.30,
//                       // child: Image(image: AssetImage('assets/The_Talk.png')),
//                     ),
//                   ),

//                   SizedBox(
//                     height: size.height * 0.043,
//                     // height: 35.46,
//                   ),
//                   Container(
//                     height: size.height * 0.034,
//                     width: size.height * 0.23,
//                     // height: 26,
//                     // width: 161,
//                     // color: Colors.blue,
//                     child: const Text(
//                       "Welcome, Back",
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xffFFFFFF),
//                           fontFamily: "Google Sans"),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.055,
//                     // height: 50,
//                   ),
//                   Column(
//                     children: [
//                       TextFormField(
//                         controller: emailController,
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (String? value) {
//                           if (value!.isEmpty) {
//                             return "email cannot be empty";
//                           } else if (EmailValidator.validate(
//                                   emailController.text.trim()) ==
//                               false) {
//                             return "Enter the valid email ";
//                           } else {
//                             return null;
//                           }
//                         },
//                         style: TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(right: 10.0),
//                             child: Container(
//                               height: size.height * 0.020,
//                               width: size.width * 0.020,
//                               // height: 20,
//                               // width: 20,
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 4, horizontal: 2),
//                                 child: Icon(
//                                   Icons.mail,
//                                   color: Color(0xffFFFFFF),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           hintText: "Email",
//                           hintStyle: const TextStyle(
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Color(0xffFFFFFF),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.031,
//                         // height: 29,
//                       ),
//                       // password
//                       TextFormField(
//                         controller: passwordController,
//                         validator: (value) {
//                           if (value!.isEmpty)
//                             return "password cannot be empty";
//                           // else if (value.length < 8)
//                           //   return "password must be atleast 8";
//                           // else if (value != (passwordController.text)) {
//                           //   final text = "verify password ";
//                           //   final snackBar = SnackBar(content: Text(text));
//                           //   ScaffoldMessenger.of(context).showSnackBar((snackBar));
//                           //   return "verify email";
//                           // }
//                           else {
//                             return null;
//                           }
//                         },
//                         style: TextStyle(color: Colors.white),
//                         obscureText: _secureText,
//                         decoration: InputDecoration(
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(right: 10.0),
//                             child: Container(
//                               // height: 20,
//                               // width: 20,
//                               height: size.height * 0.020,
//                               width: size.width * 0.020,
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 4, horizontal: 2),
//                                 child: Icon(
//                                   Icons.lock,
//                                   color: Color(0xffFFFFFF),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _secureText = !_secureText;
//                                 });
//                               },
//                               icon: _secureText
//                                   ? const Icon(
//                                       CupertinoIcons.eye_slash_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )
//                                   : const Icon(
//                                       CupertinoIcons.eye_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )),
//                           hintText: "Password",
//                           hintStyle: const TextStyle(
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Color(0xffFFFFFF),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(
//                     height: 11,
//                   ),
//                   // forgot password
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                       // onTap: () {
//                       //   UiHelper.alertDailogBox(context, "forgot Password",
//                       //       "once you forgot ur password , nothing can be done");
//                       // },
//                       child: Container(
//                         // height: 18,
//                         // width: 113,
//                         height: size.height * 0.021,
//                         width: size.width * 0.30,
//                         child: const Text(
//                           "Forgot Password?",
//                           style: TextStyle(
//                               decoration: TextDecoration.underline,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xffFFFFFF),
//                               fontFamily: "Google Sans"),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 28,
//                     height: size.height * 0.029,
//                   ),
//                   GestureDetector(
//                     onTap: () async {
//                       if (_formkey.currentState!.validate()) {
//                         try {
//                           await authService.login(
//                             emailController.text,
//                             passwordController.text,
//                           );
//                           Navigator.pushReplacementNamed(context, '/home');
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Login Failed')),
//                           );
//                         }
//                       }
//                     },
//                     child: Center(
//                       child: Container(
//                         height: size.height * 0.065,
//                         width: size.width * 0.81,
//                         child: Container(
//                           height: size.height * 0.036,
//                           width: size.width * 0.81,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(96),
//                             color: Color(0xff21C4A7),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'SIGN IN',
//                               style: TextStyle(
//                                 color: Color(0xffFFFFFF),
//                                 fontSize: 20,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 35,
//                     height: size.height * 0.045,
//                   ),

//                   Row(
//                     children: [
//                       const Expanded(
//                         child: Divider(
//                           color: Colors.white,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 6.36),
//                         child: Container(
//                           // height: 18,
//                           // width: 15.91,
//                           height: size.height * 0.021,
//                           width: size.width * 0.036,
//                           child: const Text(
//                             "Or",
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontSize: 12,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.026,
//                   ),
//                   Center(
//                     child: Container(
//                       height: size.height * 0.031,
//                       width: size.width * 0.65,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: size.height * 0.025,
//                             width: size.width * 0.45,
//                             child: const Text(
//                               "Don’t have an account ?",
//                               style: TextStyle(
//                                 color: Color(0xffFFFFFF),
//                                 fontSize: 15,
//                                 fontFamily: 'Google Sans',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () =>
//                                 Navigator.pushNamed(context, '/signup'),
//                             child: Container(
//                               height: size.height * 0.028,
//                               width: size.width * 0.189,
//                               child: const Text(
//                                 "Sign up",
//                                 style: TextStyle(
//                                   decoration: TextDecoration.underline,
//                                   color: Color(0xffFFFFFF),
//                                   fontSize: 16,
//                                   fontFamily: 'Google Sans',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.15,
//                   ),
//                   Align(
//                       alignment: Alignment.bottomRight,
//                       child: Text("Designed and developed by @Ankit")),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
