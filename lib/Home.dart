import 'package:finalproject/BookList.dart';
import 'package:finalproject/donate.dart';
import 'package:finalproject/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> body = [BookList(), VideoScreen(), Donation()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[200],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text(
            "Hamilton Public Library",
            style: GoogleFonts.akayaTelivigala(
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                icon: Icon(Icons.location_on_sharp)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/bookmark');
                },
                icon: Icon(Icons.bookmark)),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                //Navigator.pushNamed(context, '/');
                Navigator.popAndPushNamed(context, '/');
              },
              child: Text('Logout'),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_rounded),
              label: 'Videos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Donate',
            ),
          ],
        ),
        body: body[_currentIndex]);
  }
}
