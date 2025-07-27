import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_q/pages/home_page.dart';

import '../style/app_style.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  int _selectedColorIndex = 0;

  bool _isPinned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              maxLines: null, // Untuk membuat input dapat melakukan enter
              textInputAction: TextInputAction.newline, // Memberikan aksi enter pada keyboard
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


  void _saveNote() {
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    // Pastikan controller tidak null dan data dapat diambil
    if (userUid != null && _titleController.text.isNotEmpty && _descController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('note').add({
        'title': _titleController.text,
        'description': _descController.text,
        'color_id': _selectedColorIndex, // Convert warna menjadi string untuk Firestore
        'user_uid': userUid,
        'pinned': _isPinned,
      }).then((_) {
        // Berhasil menyimpan, navigasi ke HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }).catchError((error) {
        // Gagal menyimpan, tampilkan pesan atau log
        print("Error saving note: $error");
      });
    }
  }

}
