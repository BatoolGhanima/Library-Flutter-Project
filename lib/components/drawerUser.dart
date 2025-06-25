import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_service.dart';
import '../auth/login.dart';

class Draweruser extends StatefulWidget {
  const Draweruser({super.key});

  @override
  State<Draweruser> createState() => _DraweruserState();
}

class _DraweruserState extends State<Draweruser> {
  String name = 'Guest';
  String email = '';

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      email = user?.email ?? '';
      name = user?.displayName ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFE4C59E),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFAF8260)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFE4C59E),
                      child: Icon(Icons.person, color: Color(0xFF5C260D)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF5C260D),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  style: const TextStyle(
                    color: Color(0xFF5C260D),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("Settings", style: TextStyle(color: Color(0xFF5C260D))),
            leading: const Icon(Icons.settings, color: Color(0xFFAF8260)),
          ),
          const Divider(color: Color(0xFFAF8260), thickness: 0.5),
          ListTile(
            title: const Text("Theme", style: TextStyle(color: Color(0xFF5C260D))),
            leading: const Icon(Icons.brightness_6, color: Color(0xFFAF8260)),
          ),
          const Divider(color: Color(0xFFAF8260), thickness: 0.5),
          ListTile(
            title: const Text("Language", style: TextStyle(color: Color(0xFF5C260D))),
            leading: const Icon(Icons.language, color: Color(0xFFAF8260)),
          ),
          const Divider(color: Color(0xFFAF8260), thickness: 0.5),
          ListTile(
            title: const Text("Logout", style: TextStyle(color: Color(0xFF5C260D))),
            leading: const Icon(Icons.logout, color: Color(0xFFAF8260)),
            onTap: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
