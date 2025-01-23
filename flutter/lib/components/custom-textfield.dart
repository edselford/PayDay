import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hint,
      this.isPassword = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 346,
      height: 59,
      child: Container(
        width: 346,
        height: 59,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          color: Color.fromRGBO(247, 248, 249, 1),
          border: Border.all(
            color: Color.fromRGBO(238, 241, 247, 1),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 23.0, top: 0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.isPassword ? !toggle : false,
                  decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(147, 160, 173, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                  border: InputBorder.none,
                  ),
                ),
              ),
              widget.isPassword ? IconButton(onPressed: () {
                setState(() {
                  toggle = !toggle;
                });
              }, icon: Icon(toggle ? Icons.visibility : Icons.visibility_off, color: Color.fromRGBO(147, 160, 173, 1),)) : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
