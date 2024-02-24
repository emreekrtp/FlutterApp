import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});

  final QueryDocumentSnapshot doc;

  @override
  _NoteReaderScreenState createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  TextEditingController _noteTitleController = TextEditingController();
  TextEditingController _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteTitleController.text = widget.doc["note_title"];
    _noteEditingController.text = widget.doc["note_content"];
  }

  void updateNote() async {
    try {
      await FirebaseFirestore.instance
          .collection('Notes')
          .doc(widget.doc.id)
          .update({
        'note_title': _noteTitleController.text,
        'note_content': _noteEditingController.text,
      });
      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grup başlığı ve içeriği başarıyla güncellendi.'),
        ),
      );
    } catch (e) {
      // Error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grup başlığı ve içeriği güncellerken hata oluştu: $e'),
        ),
      );
    }
  }

  void deleteNote() async {
    try {
      await FirebaseFirestore.instance
          .collection('Notes')
          .doc(widget.doc.id)
          .delete();
      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grup başarıyla silindi.'),
        ),
      );
      // Optional navigation back
      Navigator.pop(context);
    } catch (e) {
      // Error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grubu silerken hata oluştu: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _noteTitleController,
              decoration: InputDecoration(
                hintText: 'Grup adı',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.doc["creation_date"],
            ),
            SizedBox(height: 28.0),
            TextField(
              controller: _noteEditingController,
              maxLines: null, // Allow multi-line content
              decoration: InputDecoration(
                hintText: 'Grup içeriğini buraya girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: updateNote,
                  child: Text('Grubu Güncelle'),
                ),
                ElevatedButton(
                  onPressed: deleteNote,
                  child: Text('Grubu Sil'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
