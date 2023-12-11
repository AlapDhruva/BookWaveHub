import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var title = '';
  var subtitle = '';
  var publisher = '';
  var publishedDate = '';
  var pageCount = '';
  var imageLink = '';
  var description = '';
  var status = 'Available';
  var type = 'Donated';

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    CollectionReference book = FirebaseFirestore.instance.collection("books");
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.all(30),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "Donate a Book",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    "'One book could be equal to 100 friends'",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                title = value;
              },
              decoration: InputDecoration(
                labelText: 'Ttile*',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                subtitle = value;
              },
              decoration: InputDecoration(
                labelText: 'Subtitle*',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                pageCount = value;
              },
              decoration: InputDecoration(
                labelText: 'Page*',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                imageLink = value;
              },
              decoration: InputDecoration(
                labelText: 'Image Link',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                publisher = value;
              },
              decoration: InputDecoration(
                labelText: 'Publisher*',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                publishedDate = value;
              },
              decoration: InputDecoration(
                labelText: 'Publish Date*',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                labelText: 'Description*',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                if (title.isEmpty ||
                    title == '' ||
                    subtitle.isEmpty ||
                    subtitle == '' ||
                    publisher.isEmpty ||
                    publisher == '' ||
                    publishedDate.isEmpty ||
                    publishedDate == '' ||
                    description.isEmpty ||
                    description == '' ||
                    pageCount.isEmpty ||
                    pageCount == '') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "One of the field is empty. Make sure you enter all the mendatory fields.")));
                } else {
                  book
                      .add({
                        'title': title,
                        'subtitle': subtitle,
                        'imageLink': imageLink,
                        'publisher': publisher,
                        'publishedDate': publishedDate,
                        'description': description,
                        'pageCount': pageCount,
                        'status': status,
                        'type': type + ' by ${user?.email}'
                      })
                      .then((value) => print("book is added"))
                      .catchError((error) => print("Error Occured!"));
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: Text('Donate'),
            ),
          ],
        ),
      ),
    );
  }
}
