import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class limage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets\morse_ogo.png');
    Image image = Image(image: assetImage);
    return Container(
      child: image,
    );
  }
}

class MInfoPage extends StatelessWidget {
  const MInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_rounded),
            color: Colors.white70,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 90),
          child: Center(
              child: Column(
            children: <Widget>[
              Image.asset(
                'assets/morse_ogo.png',
                width: 100,
                height: 100,
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 60,
                ),
                child: Column(
                  children: [
                    Text(
                      'Morse Code Flash App',
                      style: GoogleFonts.kanit(
                          textStyle:
                              TextStyle(color: Colors.white70, fontSize: 19)),
                    ),
                  ],
                ),
              ),
              Container(
                width: 350,
                height: 268,
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 35,
                  right: 20,
                  left: 20,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'What Is Morse Code?\n',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 99, 115, 150)),
                            fontSize: 18),
                      ),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text:
                            'Morse Code, either of two systems for representing letters of the alphabet, numerals, and punctuation marks by an arrangement of dots, dashes, and spaces. The codes are transmitted as electrical pulses of varied lengths or analogous mechanical or visual signals, such as flashing lights.',
                        style: GoogleFonts.sourceCodePro(
                            textStyle: TextStyle(color: Colors.white38)),
                      )
                    ]))
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
