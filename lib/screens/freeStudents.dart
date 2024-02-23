import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GrupArayanlar extends StatefulWidget {
  const GrupArayanlar({super.key});

  @override
  State<GrupArayanlar> createState() => _GrupArayanlarState();
}

class _GrupArayanlarState extends State<GrupArayanlar> {
  final _nameController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Data')
      .snapshots(); // Stream for real-time updates

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("GrupBul")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "İsminizi Giriniz"),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                // Get the name from the text field
                final name = _nameController.text;

                // Validate the name (optional)
                if (name.isEmpty) {
                  // Show an error message
                  return;
                }

                // Add the user to Firestore
                await FirebaseFirestore.instance.collection("Data").add({
                  "name": name,
                  // Add any other relevant fields here
                });

                // Show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${name} başarıyla eklendi!'),
                  ),
                );

                // Clear the text field
                _nameController.clear();
              } catch (error) {
                // Handle errors gracefully
                print("Failed to add new Data due to $error");
                // Show an error message to the user
              }
            },
            child: Text("Kaydet ve Listeye Ekle"),
          ),
          SizedBox(height: 20), // Add some space between buttons and list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final name = doc['name'] as String;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(name),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  try {
                                    // Delete the user data
                                    await doc.reference.delete();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('$name silindi.'),
                                      ),
                                    );
                                  } catch (error) {
                                    // Handle errors gracefully
                                    print(
                                        "Failed to delete data due to $error");
                                    // Show an error message to the user
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
