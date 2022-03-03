import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:morse_app/info.dart';
import 'package:morse_app/splash.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 11, 16, 27),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: Splash()),
      routes: {
        'infoPage': (ctx) {
          return MInfoPage();
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();
  String _displayText = 'Your Morse Code Will Show Here';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              SystemNavigator.pop();
            },
            color: Colors.white70,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline_rounded),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return MInfoPage();
                }));
              },
              color: Colors.white70,
              padding: EdgeInsets.only(right: 20.0),
            ),
          ]),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100, right: 40, left: 40, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 322,
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Type Here...',
                        hintStyle: TextStyle(color: Colors.white24),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 160),
                    child: Text(
                      _displayText,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(109, 135, 192, 1),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: 30,
                      left: 30,
                    )),
                onPressed: () {
                  flashHandler(context, _textController.text);

                  print(_textController.text);
                  setState(() {
                    _displayText = tomorse(_textController.text);
                  });
                },
                child: Text('Morse Code'),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

Future<bool> _isTorchAvailable(BuildContext context) async {
  try {
    return await TorchLight.isTorchAvailable();
  } on Exception catch (_) {
    _showMessage(
      'Could not check if the device has an available torch',
      context,
    );
    rethrow;
  }
}

Future<void> _enableTorch(BuildContext context) async {
  try {
    await TorchLight.enableTorch();
  } on Exception catch (_) {
    _showMessage('Could not enable torch', context);
  }
}

Future<void> _disableTorch(BuildContext context) async {
  try {
    await TorchLight.disableTorch();
  } on Exception catch (_) {
    _showMessage('Could not disable torch', context);
  }
}

void _showMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

var morseCode = {
  //Alphabets
  "A": ".-",
  "B": "-...",
  "C": "-.-.",
  "D": "-..",
  "E": ".",
  "F": "..-.",
  "G": "--.",
  "H": "....",
  "I": "..",
  "J": ".---",
  "K": "-.-",
  "L": ".-..",
  "M": "--",
  "N": "-.",
  "O": "---",
  "P": ".--.",
  "Q": "--.-",
  "R": ".-.",
  "S": "...",
  "T": "-",
  "U": "..-",
  "W": ".--",
  "X": "-..-",
  "Y": "-.--",
  "Z": "--..",
  // Numbers
  "1": ".----",
  "2": "..---",
  "3": "...--",
  "4": "....-",
  "5": ".....",
  "6": "-....",
  "7": "--...",
  "8": "---..",
  "9": "----.",
  "0": "-----",
  " ": "---",
};

String tomorse(String str) {
  return str
      .toUpperCase()
      .split("")
      .map((e) => morseCode[e] != null ? morseCode[e] : '.')
      .join();
}

void flashHandler(BuildContext context, String string) async {
  int current1 = new DateTime.now().second;

  tomorse(string).split("").forEach(await (e) async {
        if (e == '-') {
          _enableTorch(context);
          await Future.delayed(const Duration(seconds: 2));
        }

        if (e == '.') {
          _disableTorch(context);
          await Future.delayed(const Duration(seconds: 2));
        }
      });
  _disableTorch(context);
}
