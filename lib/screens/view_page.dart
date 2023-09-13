import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/user_auth/presentation/widgets/note_card.dart';
import 'package:final_project/screens/note_editor.dart';
import 'package:final_project/screens/note_reader.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Ekle & Düzenle"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NoteReaderScreen(note)));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "There's no Notes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Note"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
      ),
    );
  }
}
