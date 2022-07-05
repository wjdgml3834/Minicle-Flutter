import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({Key? key, this.colour, required this.title, required this.onPressed, required this.mainBtnColor}) : super(key: key);
  final Color? colour;
  final String title;
  final void Function()? onPressed;
  bool mainBtnColor = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Color(0xFF13B082), width: 1),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: mainBtnColor ? Colors.white : Color(0xFF13B082),
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}