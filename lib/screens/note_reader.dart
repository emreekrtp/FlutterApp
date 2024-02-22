import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});

  final QueryDocumentSnapshot doc;

  @override
  _NoteReaderScreenState createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  TextEditingController _noteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteEditingController.text = widget.doc["note_content"];
  }

  void updateNoteContent() async {
    try {
      await FirebaseFirestore.instance
          .collection('Notes')
          .doc(widget.doc.id)
          .update({'note_content': _noteEditingController.text});
      // Başarıyla güncellendiğini bildir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grup içeriği güncellendi.'),
        ),
      );
    } catch (e) {
      // Hata durumunda kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Grup içeriğini güncellerken bir hata oluştu: $e'),
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
            TextField(
              controller: _noteEditingController,
              maxLines: null, // Metnin birden fazla satıra yayılmasına izin verir
              decoration: InputDecoration(
                hintText: 'Grup içeriğini buraya girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateNoteContent,
              child: Text('Grubu Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}