import 'package:flutter/material.dart';
import 'package:library_app/auth/auth_service.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final emailController = TextEditingController();

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

              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(226, 236, 202, 157),
                      const Color.fromARGB(200, 255, 255, 255),
                    ],
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 71, 47, 38),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter your email to receive a password reset link",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 71, 47, 38),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
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
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                              hintText: "Enter your email",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextButton(
                            onPressed: () async {
                              final result = await AuthService().resetPassword(
                                emailController.text.trim(),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    result
                                        ? "Reset link sent successfully"
                                        : "Failed to send link. Please check the email.",
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Send Reset Link",
                              style: TextStyle(color: Color(0xFFFFE4C4)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: Color.fromARGB(255, 107, 71, 58),
                        ),
                      ),
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
