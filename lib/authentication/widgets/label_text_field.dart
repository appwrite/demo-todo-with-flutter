import 'package:flutter/material.dart';

class LabelTextField extends StatefulWidget {
  const LabelTextField({
    Key? key,
    required this.label,
    this.isPassword = false,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  final String label;
  final bool isPassword;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  _LabelTextFieldState createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  late bool obscureText;
  bool showIcon = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: TextField(
            cursorColor: Colors.black,
            controller: widget.controller,
            obscureText: obscureText,
            style: const TextStyle(fontSize: 18),
            onChanged: (value) {
              if (widget.isPassword) showIcon = value.isNotEmpty;
              widget.onChanged?.call(value);
            },
            decoration: InputDecoration(
              suffixIcon: widget.isPassword && showIcon
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.only(left: 10),
              focusedBorder: const UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
