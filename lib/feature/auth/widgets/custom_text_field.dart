import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isHideText;
  final Icon icon;
  final String hintText;

  const CustomTextField(this.controller, this.labelText, this.icon,
      {super.key, this.isHideText = false, this.hintText = ''});

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState(controller, labelText, isHideText, icon, hintText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _inputController;
  final String labelText;
  final bool isHideTextMode;
  final Icon icon;
  final String hintText;

  bool _hideText = false;
  final FocusNode focusNode = FocusNode();
  TextStyle labelStyle = TextStyle(
      color: const Color(0xff765827),
      fontFamily: GoogleFonts.merriweather().fontFamily);

  _CustomTextFieldState(this._inputController, this.labelText,
      this.isHideTextMode, this.icon, this.hintText);

  @override
  void initState() {
    super.initState();
    _hideText = isHideTextMode;
    focusNode.addListener(onFocusChange);
  }

  void onFocusChange() {
    setState(() {
      labelStyle = focusNode.hasFocus
          ? TextStyle(
              color: const Color(0xff333333),
              fontFamily: GoogleFonts.merriweather().fontFamily)
          : TextStyle(
              color: const Color(0xff765827),
              fontFamily: GoogleFonts.merriweather().fontFamily);
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: _inputController,
      style: TextStyle(fontFamily: GoogleFonts.merriweather().fontFamily),
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon,
          hintText: hintText,
          labelStyle: labelStyle,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF765827), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          suffixIcon: isHideTextMode
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _hideText = !_hideText;
                    });
                  },
                  icon: _hideText
                      ? const Icon(Icons.remove_red_eye_sharp)
                      : const Icon(Icons.remove_red_eye_outlined))
              : null),
      obscureText: _hideText,
    );
  }
}
