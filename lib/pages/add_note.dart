import 'package:flutter/material.dart';
import 'package:note_q/models/list_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
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
          IconButton(onPressed: () {},
            icon: const Icon(
              Icons.push_pin_outlined,
            ),
          ),
          IconButton(onPressed: () {},
              icon: const Icon(
                Icons.dashboard_outlined,
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
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Spacer(),
              InkWell(
                onTap: (){},
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
                      ]
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Icon(
                    Icons.check,
                  ),
                ),
              ),
              Spacer(),
              Row(
                children:
                  List.generate(
                      products.length, (index) => colorSelection(index)),
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
            // title
            TextFormField(
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              decoration:const InputDecoration(
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
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration:const InputDecoration(
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

  Padding colorSelection(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
                onTap: (){},
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: products[index].color,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ),
    );
  }
}
