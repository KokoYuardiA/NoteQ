import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_q/pages/home_page.dart';

import '../style/app_style.dart';

class EditNote extends StatefulWidget {
  final QueryDocumentSnapshot noteDocument;

  const EditNote({Key? key, required this.noteDocument}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late int _selectedColorIndex;
  late bool _isPinned;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> data = widget.noteDocument.data() as Map<String, dynamic>;

    _titleController = TextEditingController(text: data['title']);
    _descController = TextEditingController(text: data['description']);
    _selectedColorIndex = data['color_id'];
    _isPinned = data['pinned'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black54),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isPinned = !_isPinned;
              });
            },
            icon: Icon(
              _isPinned
                  ? Icons.push_pin
                  : Icons.push_pin_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              _deleteNote();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              spreadRadius: 2.0,
              blurRadius: 5.0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Spacer(),
                InkWell(
                  onTap: () => _saveNote(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Icon(
                      Icons.check,
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: List.generate(
                    AppStyle.cardsColor.length,
                        (index) => colorSelection(index, AppStyle.cardsColor),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                hintText: "Enter title",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              // ... (kode lainnya)
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _descController,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              maxLines: null,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: "Enter description",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding colorSelection(int index, List<Color> colors) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedColorIndex = index;
          });
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: colors[index],
            borderRadius: BorderRadius.circular(10.0),
            border: _selectedColorIndex == index
                ? Border.all(color: Colors.black, width: 2.0)
                : null,
          ),
        ),
      ),
    );
  }

  // ... (kode lainnya)

  void _saveNote() {
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    if (userUid != null && _titleController.text.isNotEmpty && _descController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('note')
          .doc(widget.noteDocument.id)
          .update({
        'title': _titleController.text,
        'description': _descController.text,
        'color_id': _selectedColorIndex,
        'pinned': _isPinned,
      }).then((_) {
        Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menyimpan
      }).catchError((error) {
        print("Error updating note: $error");
      });
    }
  }
  void _deleteNote() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Tutup dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Hapus catatan dan tutup dialog
                FirebaseFirestore.instance
                    .collection('note')
                    .doc(widget.noteDocument.id)
                    .delete()
                    .then((_) {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menghapus
                }).catchError((error) {
                  print("Error deleting note: $error");
                  // Handle error deleting note if needed
                  Navigator.pop(dialogContext);
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

}
