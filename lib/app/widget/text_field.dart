import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'constant.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final TextInputType keyboardType;
  bool obscurePassword;
  IconData? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.validator,
    this.inputFormatters,
    this.onChanged,
    this.obscurePassword = false,
    this.suffixIcon,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.obscurePassword,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF19164C)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 14.0, 15.0),
          child: SvgPicture.asset(widget.prefixIcon),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color(0xFF7B78AA)),
        suffixIconColor: const Color(0xFF7B78AA),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.obscurePassword = !widget.obscurePassword;
              if (widget.obscurePassword) {
                widget.suffixIcon = CupertinoIcons.eye_fill;
              } else {
                widget.suffixIcon = CupertinoIcons.eye_slash_fill;
              }
            });
          },
          icon: Icon(widget.suffixIcon),
        ),
      ),
    );
  }
}
