import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({super.key});

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Notlar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  right: 100.0, left: 8.0, top: 8.0, bottom: 8.0),
              child: FormContainerWidget(
                controller: textController,
                hintText: "Yazınız",
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ekle",
        child: Icon(Icons.note_add_outlined),
        onPressed: () {},
      ),
    );
  }
}

/*
MediaQuery.of(context).size.width/1.3,
 */
