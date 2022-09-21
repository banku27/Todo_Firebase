import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              ref.add({
                'title': title.text,
                'content': content.text,
              }).whenComplete(
                () => Navigator.pop(context),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Content',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
