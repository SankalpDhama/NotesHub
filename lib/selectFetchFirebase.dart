import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class selectFetch extends StatelessWidget {
  final String s;
  const selectFetch({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Replace 'your_collection' with the name of your collection
      stream: FirebaseFirestore.instance.collection(s).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // 'snapshot.data' contains the QuerySnapshot with all documents
        final documents = snapshot.data!.docs;

        // You can now build your widgets using the documents data
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: documents.length,
          itemBuilder: (context, index) {
            // Access individual document data using 'documents[index]'
            final data = documents[index].data();

            // Return your custom widget with the data
            return DocumentWidget(data: data as Map<String, dynamic>);
          },
        );
      },
    );
  }
}

class DocumentWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  DocumentWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    // Display all fields in a card
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection('Selected');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.entries.map((entry) {
          return ListTile(
            // Field name
            title: Text(entry.value.toString()), // Field value
          );
        }).toList(),
      ),
    );
  }
}
