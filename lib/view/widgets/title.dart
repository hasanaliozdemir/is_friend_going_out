import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon(
        //   Icons.group,
        //   color: Colors.white,
        //   size: 60.0,
        // ),
        SizedBox(
          width: 100,
          child: Image.asset(
            'assets/gidioz.png',
            fit: BoxFit.contain,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Nereye Gidioz',
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
