import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../style/app_style.dart';
import '../edit_note.dart';

class ListData extends StatelessWidget {
  final String? searchText;
  final ValueChanged<String>? onSearchTextChanged;

  const ListData({
    Key? key,
    this.searchText,
    this.onSearchTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('note')
            .where('user_uid', isEqualTo: userUid)
            .orderBy('pinned', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Tampilkan loading indicator
            );
          }

          List<QueryDocumentSnapshot> pinnedNotes = [];
          List<QueryDocumentSnapshot> otherNotes = [];

          snapshot.data!.docs.forEach((note) {
            if (note['pinned'] == true) {
              pinnedNotes.add(note);
            } else {
              otherNotes.add(note);
            }
          });

          // Menerapkan filter pencarian
          var filteredPinnedNotes = pinnedNotes.where((note) {
            Map<String, dynamic> data = note.data() as Map<String, dynamic>;
            String title = data['title'] ?? '';
            String description = data['description'] ?? '';
            return title.contains(searchText ?? '') || description.contains(searchText ?? '');
          }).toList();

          var filteredOtherNotes = otherNotes.where((note) {
            Map<String, dynamic> data = note.data() as Map<String, dynamic>;
            String title = data['title'] ?? '';
            String description = data['description'] ?? '';
            return title.contains(searchText ?? '') || description.contains(searchText ?? '');
          }).toList();

          return Column(
            children: [
              Container(
                color: Colors.yellow,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: filteredPinnedNotes.length,
                  itemBuilder: (context, index) => ListCard(
                    noteDocument: filteredPinnedNotes[index],
                    press: () {},
                  ),
                ),
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: filteredOtherNotes.length,
                itemBuilder: (context, index) => ListCard(
                  noteDocument: filteredOtherNotes[index],
                  press: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}





class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.noteDocument,
    required this.press,
  }) : super(key: key);

  final QueryDocumentSnapshot noteDocument;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = noteDocument.data() as Map<String, dynamic>;

    int colorIndex = data['colorIndex'] ?? 0; // Ganti dengan nama field yang menyimpan indeks warna di Firestore

    Color cardColor = AppStyle.cardsColor[colorIndex];

    print("Data from Firestore: $data"); // Tambahkan log ini

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNote(
              noteDocument: noteDocument,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppStyle.cardsColor[data['color_id'] ?? 0],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data['pinned'] == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent, // Warna untuk catatan terpinned
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'Pinned',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            Text(
              data['title'] ?? 'Title',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              data['description'] ?? 'Description',
              maxLines: 3, // Atur jumlah baris maksimum yang ingin ditampilkan
              overflow: TextOverflow.ellipsis, // Tambahkan titik elipsis (...) jika lebih dari jumlah maksimum baris
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

