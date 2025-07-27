import 'package:flutter/material.dart';

class ListButtonContainer extends StatelessWidget {
  const ListButtonContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ListButton(isActive: true,title: "Notes", press: () {  },),
        ],
      ),
    );
  }
}

class ListButton extends StatelessWidget {
  ListButton({
    Key? key,
    this.isActive=false,
    required this.title,
    required this.press,
  }) : super(key: key);
  final String title;
  final VoidCallback press;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:press,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              color: isActive==true ? Colors.black : Colors.grey,
              fontWeight:
              isActive==true ? FontWeight.bold : FontWeight.normal),
        ));
  }
}
