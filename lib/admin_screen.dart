import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/admin%20user.dart';
import 'package:recipe_app/admin_recipelist.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;


  Widget _getBodyForSelectedIndex() {
    switch (_selectedIndex) {
      case 0:
        return Recipes();
      case 1:
        return UserList();
      default:
        return Recipes();
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Admin Panel"),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
        body: _getBodyForSelectedIndex(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Recipe',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Users',
            ),
          ],
        ),

    );
  }

}
