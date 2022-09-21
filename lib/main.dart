import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/add_note.dart';
import 'package:todo_firebase/edit_note.dart';
import 'package:todo_firebase/firebase_options.dart';
import 'package:todo_firebase/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('notes');
  HomePage({super.key});

  // Future<void> getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await ref.get();
  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   print(allData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TGD Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Note>>(
        stream: ref.snapshots().map((event) {
          List<Note> notes = [];
          event.docs.forEach((element) {
            notes.add(Note.fromMap(element.data(), element.reference.id));
          });
          return notes;
        }),
        builder: (context, snapshot) => GridView.builder(
            itemCount: snapshot.hasData ? snapshot.data!.length : 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              var notes = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditNote(docToEdit: snapshot.data![index]),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 170,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Text(
                        notes.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(notes.content),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
