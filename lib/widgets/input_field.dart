import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final double width;
  final double height;

  const InputField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.width = 268,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 24,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: Color(0xFF7C7C7C),
          height: 1.15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.only(
            left: 27,
            right: 20,
            top: 13,
            bottom: 13,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
