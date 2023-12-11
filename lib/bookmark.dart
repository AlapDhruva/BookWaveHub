import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> bookmarks =
      FirebaseFirestore.instance.collection("bookmarks").snapshots();
  List bookmarkList = [];
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Bookmarks"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: bookmarks,
        builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final data = snapshot.requireData;

          final finalData = makeFinalList(data, user?.email);

          return Container(
            //color: Colors.deepOrange[400],
            child: ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    bookmarkList[index]['title'] == ''
                        ? ''
                        : data.docs[index]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    bookmarkList[index]['subtitle'] == ''
                        ? ''
                        : data.docs[index]['subtitle'],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  leading: Image.network(
                    bookmarkList[index] == ''
                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV5emPzy2ZtKXT3hG2EpVwmrREcNN7N3spMg&usqp=CAU'
                        : bookmarkList[index]['imageLink'],
                    width: 50,
                    height: 70,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void makeFinalList(QuerySnapshot<Object?> data, String? email) {
    for (int i = 0; i < data.size; i++) {
      if (data.docs[i]['user'].toString() == email) {
        bookmarkList.add(data.docs[i]);
      }
    }
  }
}
