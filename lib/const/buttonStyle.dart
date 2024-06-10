import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_system/const/constant.dart';

class BlueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const BlueButton({super.key,
  required this.onPressed,
  required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => primaryBlue.shade900),
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),),
      ),
      
      child: Text(text, 
        style: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Colors.white,
          ),
        ),
    );
  }
}


class BlueOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  
  const BlueOutlineButton({super.key,
  required this.onPressed,
  required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: primaryBlue.shade900),
        ),
      ),
      child: Text(text,
        style: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: primaryBlue.shade900,
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color borderColor;
  final Color textColor;

  const CustomOutlineButton({super.key,
  required this.onPressed,
  required this.text,
  required this.borderColor,
  required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: borderColor),
        ),
      ),
      child: Text(text,
        style: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: textColor,
        ),
      ),
    );
  }
}


