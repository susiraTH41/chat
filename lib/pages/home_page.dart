import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/auth/auth_service.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  int _selectedIndex = 1;

  List<Widget> _pageWidget() => <Widget>[
        _buildUserList131(),
        _buildUserList(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageWidget = _pageWidget();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sensor_door_outlined),
            label: 'Controls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Logs',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black87,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildUserList131() {
    return SafeArea(child: Text('gdsgdsg'));
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
