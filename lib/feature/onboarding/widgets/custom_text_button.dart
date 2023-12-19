import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final MaterialStateProperty<Size>? fixedSize;
  final Function()? onPressed;
  final String buttonText;
  final String variant;

  const CustomTextButton(
      {this.buttonText = '',
      this.fixedSize,
      this.onPressed,
      this.variant = 'primary',
      super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize:
                fixedSize ?? MaterialStateProperty.all(Size(screenWidth, 60)),
            backgroundColor: MaterialStateProperty.all(
                variant == 'primary' ? const Color(0xFF765827) : Colors.white)),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:
                  variant == 'primary' ? Colors.white : const Color(0xFF765827),
              fontSize: 18,
              fontFamily: GoogleFonts.merriweather().fontFamily),
        ));
  }
}
