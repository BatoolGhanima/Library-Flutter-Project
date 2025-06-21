import 'package:flutter/material.dart';
import 'package:library_app/auth/auth_service.dart';
import 'package:library_app/auth/register.dart';
import 'package:library_app/pages/HomePage.dart';


import 'reset_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 85, 63, 46),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.7,
            child: Image.asset('assets/images/bookBackground.jpg', fit: BoxFit.cover),
          ),
          Positioned(
            top: screenHeight * 0.35,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(232, 236, 202, 157),
                        const Color.fromARGB(200, 255, 255, 255),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "SING IN",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 71, 47, 38),
                        ),
                      ),
                      Text(
                        "Welcome back ! Nice to see you again",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 71, 47, 38),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 107, 79, 66),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: emailController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                                hintText: "Enter Your Email",
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 107, 79, 66),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                                hintText: "Enter Your Password",
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResetPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgotten Password ?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 107, 71, 58),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 69, 49, 40),
                                Color.fromARGB(255, 171, 121, 99),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 146, 121, 113),
                                blurRadius: 2,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: TextButton(
                              onPressed: () async {
                                final user = await AuthService().signIn(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );
                                if (user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>Homepage(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("sing in failed")),
                                  );
                                }
                              },
                              child: Text(
                                "Sing in",
                                style: TextStyle(color: Color(0xFFFFE4C4)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account ?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Register()),
                              );
                            },
                            child: Text(
                              "create an account",
                              style: TextStyle(
                                color: Color.fromARGB(255, 104, 69, 56),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
