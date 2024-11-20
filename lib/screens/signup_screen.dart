import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _secureTextPass1 = true;
  bool _secureTextPass2 = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Center(
                    child: Container(
                      height: size.height * 0.12,
                      width: size.width * 0.30,
                      // child: Image(image: AssetImage('assets/The_Talk.png')),
                    ),
                  ),
                  SizedBox(height: size.height * 0.043),
                  Container(
                    height: size.height * 0.036,
                    width: size.height * 0.80,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffFFFFFF),
                        fontFamily: "Google Sans",
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.018),
                  Container(
                    height: size.height * 0.024,
                    width: size.height * 0.25,
                    child: const Text(
                      "Get started by creating an account.",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF),
                        fontFamily: "Google Sans",
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.038),
                  Column(
                    children: [
                      SizedBox(height: size.height * 0.035),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          } else if (!EmailValidator.validate(value.trim())) {
                            return "Enter a valid email";
                          } else if (value.trim().length < 5) {
                            return "Email should have at least 5 characters";
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
                              child: const Icon(
                                Icons.mail,
                                color: Color(0xffFFFFFF),
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
                      SizedBox(height: size.height * 0.031),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 5) {
                            return "Password should have at least 5 characters";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureTextPass1,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: size.height * 0.020,
                              width: size.width * 0.020,
                              child: const Icon(
                                Icons.lock,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _secureTextPass1 = !_secureTextPass1;
                              });
                            },
                            icon: _secureTextPass1
                                ? Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: Color(0xffFFFFFF),
                                  )
                                : Icon(
                                    CupertinoIcons.eye_fill,
                                    color: Color(0xffFFFFFF),
                                  ),
                          ),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.035),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name cannot be empty";
                          } else if (value.length < 5) {
                            return "Name should have at least 5 characters";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureTextPass2,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: size.height * 0.020,
                              width: size.width * 0.020,
                              child: const Icon(
                                Icons.edit_note,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _secureTextPass2 = !_secureTextPass2;
                              });
                            },
                            icon: _secureTextPass2
                                ? const Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: Color(0xffFFFFFF),
                                  )
                                : const Icon(
                                    CupertinoIcons.eye_fill,
                                    color: Color(0xffFFFFFF),
                                  ),
                          ),
                          hintText: "User Name",
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
                  SizedBox(height: size.height * 0.032),
                  SizedBox(height: size.height * 0.030),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await authService.signup(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            nameController.text.trim(),
                          );
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Signup Failed')),
                          );
                        }
                      }
                    },
                    child: Center(
                      child: Container(
                        height: size.height * 0.069,
                        width: size.width * 0.81,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(96),
                          color: Color(0xff21C4A7),
                        ),
                        child: Center(
                          child: Container(
                            height: 30,
                            width: 311,
                            child: const Center(
                              child: Text(
                                'SIGN UP',
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
                    ),
                  ),
                  SizedBox(height: size.height * 0.030),
                  Center(
                    child: Container(
                      height: size.height * 0.037,
                      width: size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 15,
                              fontFamily: 'Google Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, '/login'),
                            child: Container(
                              height: size.height * 0.025,
                              width: size.width * 0.163,
                              child: const Text(
                                "Sign in",
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
                  SizedBox(height: size.height * 0.03),
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
// import '../services/auth_service.dart';

// class SignupScreen extends StatefulWidget {
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   TextEditingController nameController = TextEditingController();

//   final _formkey = GlobalKey<FormState>();
//   bool _secureTextpass1 = true;
//   bool _secureTextpass2 = true;
//   bool _checkBox = false;

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
//                     // height: 35.46,
//                     height: size.height * 0.043,
//                   ),
//                   Container(
//                     // height: 26,
//                     // width: 80,
//                     height: size.height * 0.036,
//                     width: size.height * 0.80,
//                     // color: Colors.red,
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                           height: 1.2,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xffFFFFFF),
//                           fontFamily: "Google Sans"),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 16,
//                     height: size.height * 0.018,
//                   ),
//                   Container(
//                     // height: 20,
//                     // width: 194,
//                     height: size.height * 0.024,
//                     width: size.height * 0.25,
//                     // color: Colors.red,
//                     child: const Text(
//                       "Get started by creating account.",
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xffFFFFFF),
//                           fontFamily: "Google Sans"),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 34,
//                     height: size.height * 0.038,
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: size.height * 0.035,
//                       ),
//                       TextFormField(
//                         controller: emailController,
//                         // autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (String? value) {
//                           if (value!.isEmpty) {
//                             return "email cannot be empty";
//                           } else if (EmailValidator.validate(
//                                   emailController.text.trim()) ==
//                               false) {
//                             return "verify email again ";
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

//                       TextFormField(
//                         controller: passwordcontroller,
//                         // keyboardType: TextInputType.visiblePassword,
//                         validator: (value) {
//                           if (value!.isEmpty)
//                             return "password cannot be empty";
//                           // else if (value.length < 8)
//                           //   return "password must be atleast 8";
//                           else
//                             return null;
//                         },
//                         style: TextStyle(color: Colors.white),
//                         obscureText: _secureTextpass1,
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
//                                   _secureTextpass1 = !_secureTextpass1;
//                                 });
//                               },
//                               icon: _secureTextpass1
//                                   ? Icon(
//                                       CupertinoIcons.eye_slash_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )
//                                   : Icon(
//                                       CupertinoIcons.eye_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )),
//                           hintText: "Enter Password",
//                           hintStyle: TextStyle(
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Color(0xffFFFFFF),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         // height: 30,
//                         height: size.height * 0.035,
//                       ),
//                       // Conform password
//                       TextFormField(
//                         controller: nameController,
//                         validator: (value) {
//                           if (value!.isEmpty)
//                             return "name cannot be empty";
//                           else
//                             return null;
//                         },
//                         style: TextStyle(color: Colors.white),
//                         obscureText: _secureTextpass2,
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
//                                   _secureTextpass2 = !_secureTextpass2;
//                                 });
//                               },
//                               icon: _secureTextpass2
//                                   ? const Icon(
//                                       CupertinoIcons.eye_slash_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )
//                                   : const Icon(
//                                       CupertinoIcons.eye_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )),
//                           hintText: "User name",
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

//                   //
//                   SizedBox(
//                     // height: 28,
//                     height: size.height * 0.032,
//                   ),

//                   SizedBox(
//                     height: size.height * 0.030,
//                   ),
//                   // signUp
//                   GestureDetector(
//                     onTap: () async {
//                       if (_formkey.currentState!.validate()) {
//                         try {
//                           print("here");
//                           await authService.signup(
//                             emailController.text,
//                             passwordcontroller.text,
//                             nameController.text,
//                           );
//                           Navigator.pushReplacementNamed(context, '/home');
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Signup Failed')),
//                           );
//                         }
//                       }
//                     },
//                     child: Center(
//                       child: Container(
//                         // height: 56,
//                         // width: 311,
//                         height: size.height * 0.069,
//                         width: size.width * 0.81,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(96),
//                           color: Color(0xff21C4A7),
//                         ),
//                         child: Center(
//                           child: Container(
//                             // color: Colors.red,
//                             height: 30,
//                             width: 311,
//                             child: const Center(
//                               child: Text(
//                                 'SIGN UP',
//                                 style: TextStyle(
//                                   color: Color(0xffFFFFFF),
//                                   fontSize: 20,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 25,
//                     height: size.height * 0.030,
//                   ),
//                   //Already have an account ?
//                   Center(
//                     child: Container(
//                       // height: 20,
//                       // width: 242,
//                       // color: Colors.green,
//                       height: size.height * 0.037,
//                       width: size.width * 0.65,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Already have an account ?",
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontSize: 15,
//                               fontFamily: 'Google Sans',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () => Navigator.pushNamed(context, '/login'),
//                             child: Container(
//                               height: size.height * 0.025,
//                               width: size.width * 0.163,
//                               child: const Text(
//                                 "Sign in",
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
//                     height: size.height * 0.09,
//                   ),
//                   Align(
//                       alignment: Alignment.bottomRight,
//                       child: Text("Designed and developed by @Ankit")),
//                   SizedBox(
//                     height: size.height * 0.012,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
