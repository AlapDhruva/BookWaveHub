import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookDescription extends StatefulWidget {
  const BookDescription({super.key});

  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    CollectionReference bookmark =
        FirebaseFirestore.instance.collection("bookmarks");
    final args = ModalRoute.of(context)!.settings.arguments
        as QueryDocumentSnapshot<Object?>;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(args['title']),
        ),
        backgroundColor: Colors.orange[200],
        bottomNavigationBar: BottomAppBar(
          height: 50,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
            ),
            onPressed: () {
              bookmark
                  .add({
                    'title': args['title'],
                    'subtitle': args['subtitle'],
                    'imageLink': args['imageLink'],
                    'publisher': args['publisher'],
                    'publishedDate': args['publishedDate'],
                    'description': args['description'],
                    'pageCount': args['description'],
                    'status': args['status'],
                    'type': args['type'],
                    'user': user?.email,
                  })
                  .then((value) => print("book is added"))
                  .catchError((error) => print("Error Occured!"));
              Navigator.pushNamed(context, '/home');
            },
            child: Text(
              "BookMark",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Image.network(args['imageLink'] == ''
                  ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV5emPzy2ZtKXT3hG2EpVwmrREcNN7N3spMg&usqp=CAU'
                  : args['imageLink']),
            ),
            Text(args['description']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Title: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              args['title'],
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Subtitle: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              args['subtitle'],
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "page: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              args['pageCount'],
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Publisher: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              args['publisher'],
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Publish Date: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              args['publishedDate'],
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Status: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              args['status'],
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Type: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              args['type'],
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
