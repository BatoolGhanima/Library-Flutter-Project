import 'package:flutter/material.dart';
import 'package:library_app/auth/auth_service.dart';
import 'package:library_app/auth/login.dart';

// import 'package:libraryproject/screens/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUpUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final user = await AuthService().signUp(email, password);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("فشل إنشاء الحساب")));
    }
  }

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
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(204, 236, 202, 157),
                      const Color.fromARGB(200, 255, 255, 255),
                    ],
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "SING UP",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 71, 47, 38),
                      ),
                    ),
                    Text(
                      "Welcome To LibBook !",
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 71, 47, 38),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 25),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 5),
                    //       child: TextField(
                    //         decoration: InputDecoration(
                    //           suffixIcon: Icon(
                    //             Icons.person,
                    //             color: Colors.brown,
                    //           ),
                    //           border: InputBorder.none,
                    //           hintText: "Enter Your Name",
                    //           hintStyle: TextStyle(
                    //             color: Color.fromARGB(148, 184, 145, 115),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 107, 79, 66),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
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
                    SizedBox(height: 10),
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
                            obscureText: true,
                            controller: passwordController,
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
                    SizedBox(height: 10),
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
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                              hintText: "confirm password",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

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
                          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                          child: TextButton(
                            onPressed: signUpUser,
                            child: Text(
                              "Sing Up",
                              style: TextStyle(color: Color(0xFFFFE4C4)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            "login",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 104, 69, 56),
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
        ],
      ),
    );
  }
}
