import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  String _searchQuery = '';

  Future<void> _makeAdmin(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'isAdmin': true});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User promoted to admin')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to promote user: $e')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserSearch(onChanged: (value) => setState(() => _searchQuery = value)),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final filteredDocs = snapshot.data!.docs.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final email = data['email'] ?? '';
                return email.toLowerCase().contains(_searchQuery);
              }).toList();

              if (filteredDocs.isEmpty) {
                return Center(child: Text('No users found'));
              }

              return ListView.builder(
                itemCount: filteredDocs.length,
                itemBuilder: (context, index) {
                  final doc = filteredDocs[index];
                  final data = doc.data() as Map<String, dynamic>;
                  final email = data['email'] ?? 'No email';
                  final isAdmin = data['isAdmin'] ?? false;

                  return ListTile(
                    title: Text(email),
                    trailing: ElevatedButton(
                      onPressed: isAdmin ? null : () => _makeAdmin(doc.id),
                      child: Text(isAdmin ? 'Admin' : 'Make Admin'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}


class UserSearch extends StatelessWidget {
  final Function(String) onChanged;

  UserSearch({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search by email',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
