import 'package:chatt/Home/presentation/widgets/botton_nav.dart';
import 'package:chatt/Login/presentation/pages/login_screen.dart';
import 'package:chatt/chat/presentation/pages/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    print("Signed out");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: Colors.black,
        child: Icon(Icons.chat_sharp,color: Colors.white,),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "chatty",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
        ),
        leading: Container(),
        actions: [
          TextButton(
              onPressed: () {
                signOut();
              },
              child: Text(
                "Logout",
                style: GoogleFonts.poppins(color: Colors.red),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "error",
              style: TextStyle(color: Colors.white),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: const CircularProgressIndicator(
              color: Colors.white,
            ));
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade700,
                child: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              title: Text(data['email'],
                  style: GoogleFonts.poppins(color: Colors.black)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        uid: data['userId'],
                        userEmail: data['email'],
                      ),
                    ));
              },
            ),
            Divider()
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
