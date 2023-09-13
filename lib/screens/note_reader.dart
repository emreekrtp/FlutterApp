import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});

  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"],
            ),
            SizedBox(
              height: 28.0,
            ),
            Text(
              widget.doc["note_content"],
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
