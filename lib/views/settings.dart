import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../Utils/constants.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          // Profile Section
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                "assets/image/raktim.png", // Replace with the correct path to your asset image
              ),
            ),
            title: const Text(
              "Raktim Chowdhury", // Replace with actual user name
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: const Text("raktimchowdhury39@gmail.com"), // Replace with actual email
          ),
          const Divider(),

          // Account Settings
          ListTile(
            leading: const Icon(Iconsax.user, color: Colors.grey),
            title: const Text("Account Settings"),
            onTap: () {
              // Navigate to account settings screen
            },
          ),

          // Notifications
          ListTile(
            leading: const Icon(Iconsax.notification, color: Colors.grey),
            title: const Text("Notifications"),
            onTap: () {
              // Navigate to notifications settings screen
            },
          ),

          // Privacy and Security
          ListTile(
            leading: const Icon(Iconsax.lock, color: Colors.grey),
            title: const Text("Privacy & Security"),
            onTap: () {
              // Navigate to privacy & security screen
            },
          ),

          const Divider(),

          // Logout Option
          ListTile(
            leading: const Icon(Iconsax.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              bool? confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Sign Out"),
                  content: const Text("Are you sure you want to sign out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Sign Out"),
                    ),
                  ],
                ),
              );

              if (confirm ?? false) {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login screen
              }
            },
          ),
        ],
      ),
    );
  }
}
