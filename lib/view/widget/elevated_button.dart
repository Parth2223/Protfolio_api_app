import 'package:flutter/material.dart';

class customElevetedButton extends StatelessWidget {
  customElevetedButton({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      // width: 90,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
