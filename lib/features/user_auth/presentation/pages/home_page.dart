import 'package:final_project/features/user_auth/presentation/pages/login_page.dart';
import 'package:final_project/screens/view_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("dd.MM.yyyy").format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text("GrupBul")],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                formattedDate,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            "Hoşgeldin!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          )),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.yellow,
            ),
            child: const Text("Gruplar"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ViewPage()));
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.yellow,
            ),
            child: const Text("Çıkış Yap"),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
