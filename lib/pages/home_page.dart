import 'package:flutter/material.dart';
import 'package:note_q/style/app_style.dart';

import 'components/bottom_bar.dart';
import 'components/custom_appbar.dart';
import 'components/list_button.dart';
// import 'components/list_data.dart';
import 'components/list_data_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _searchText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      bottomNavigationBar: const CustomBottomBar(),
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(),

            // Search bar section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // List Button section
            ListButtonContainer(),

            // Card List
            ListData(searchText: _searchText),
          ],
        ),
      ),
    );
  }
}

