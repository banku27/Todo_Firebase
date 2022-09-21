import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/model.dart';

class EditNote extends StatefulWidget {
  Note docToEdit;

  EditNote({
    Key? key,
    required this.docToEdit,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.title);
    content = TextEditingController(text: widget.docToEdit.content);

    super.initState();
  }

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
            onPressed: () async {
              final String title1 = title.text;
              final String content1 = content.text;

              if (content != null) {
                await ref.add({'title': title1, 'content': content1});
              }

              Navigator.of(context).pop();
              // ref.add({
              //   'title': title.text,
              //   'content': content.text,
              // }).whenComplete(
              //   () => Navigator.pop(context),
              // );
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

  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      title.text = documentSnapshot['title'];
      content.text = documentSnapshot['content'];
    }
  }
}
