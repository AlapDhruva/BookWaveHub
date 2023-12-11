import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final Stream<QuerySnapshot> books =
      FirebaseFirestore.instance.collection("books").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: books,
      builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final data = snapshot.requireData;
        return Container(
          //color: Colors.deepOrange[400],
          child: ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/bookdetail',
                      arguments: data.docs[index]);
                },
                title: Text(
                  data.docs[index]['title'] == ''
                      ? ''
                      : data.docs[index]['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  data.docs[index]['subtitle'] == ''
                      ? ''
                      : data.docs[index]['subtitle'],
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                leading: Image.network(
                  data.docs[index]['imageLink'] == ''
                      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV5emPzy2ZtKXT3hG2EpVwmrREcNN7N3spMg&usqp=CAU'
                      : data.docs[index]['imageLink'],
                  width: 50,
                  height: 70,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
