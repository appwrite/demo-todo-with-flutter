import 'package:flutter/material.dart';

class InvertedColorButton extends StatelessWidget {
  const InvertedColorButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.hovered))
              return Colors.white;
            else if (states.contains(MaterialState.disabled))
              return const Color(0xFF888C93);
            return Colors.black;
          },
        ),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered))
            return const BorderSide();
          else if (states.contains(MaterialState.disabled))
            return const BorderSide(color: Color(0xFF888C93));
          return const BorderSide(color: Colors.white);
        }),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 60, vertical: 22),
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.hovered))
              return Colors.black;
            else if (states.contains(MaterialState.disabled))
              return Colors.white54;
            return Colors.white;
          },
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
