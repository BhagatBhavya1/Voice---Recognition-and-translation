import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgp/Assets/toggle_screen.dart';
import 'package:sgp/Login.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text2pdf/text2pdf.dart';
import 'package:translator/translator.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  GoogleTranslator translator = GoogleTranslator();
  String current_len = 'en';
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    Duration(minutes: 5);
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void language_selector() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        backgroundColor: Colors.grey,
        context: context,
        builder: (context) => StatefulBuilder(builder: ((context, setState) {
              return Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select Lenguage ',
                      style: TextStyle(fontSize: 25),
                    ),
                    TextButton(
                        onPressed: () {
                          translation('gu');
                        },
                        child: Text(
                          'Gujarati',
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                    )),
                    TextButton(
                        onPressed: () {
                          translation('hi');
                        },
                        child: Text(
                          'Hindi',
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                    )),
                    TextButton(
                        onPressed: () {
                          translation('gd');
                        },
                        child: Text(
                          'German',
                          style: TextStyle(color: Colors.white),
                        )),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                    )),
                    TextButton(
                        onPressed: () {
                          translation('ru');
                        },
                        child: Text(
                          'Russian',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              );
            })));
  }

  void translation(l) {
    translator.translate(_lastWords, from: current_len, to: l).then(
      (va) {
        setState(() {
          _lastWords = va.toString();
        });
      },
    );
    current_len = l;
  }

  signout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.deepOrange,
              actions: [
                IconButton(
                  onPressed: () {
                    signout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => toggle(),
                      ),
                    );
                  },
                  color: Colors.black12,
                  icon: Icon(Icons.logout_rounded),
                )
              ],
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepOrange, Colors.orange])),
              child: RawMaterialButton(
                onPressed: _startListening,
                onLongPress: _stopListening,
                child: Icon(
                  Icons.mic,
                  size: 50,
                ),
                padding: EdgeInsets.only(top: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white70,
                    // border: Border.all(color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(
                          3.0,
                          3.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(_speechToText.isListening
                          ? '$_lastWords'
                          //                 // If listening isn't active but could be tell the user
                          //                 // how to start it, otherwise indicate that speech
                          //                 // recognition is not yet ready or not supported on
                          //                 // the target device
                          : _speechEnabled
                              ? '$_lastWords'
                              : 'Bhavya'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              // child: ElevatedButton(
              //     onPressed: language_selector, child: Text('translate')),
              child: ElevatedButton(
                child: Text(
                  'Translate',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.black,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(15)),
                onPressed: language_selector,
              ),
            ),
            SizedBox(
              height: 60,
              width: 200,
              child: _button(_lastWords),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _button(_last) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      // Share
      ElevatedButton(
        child: Text(
          'Share',
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.black,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(15)),
        onPressed: () async {
          if (_last != Null) {
            await Share.share(_last);
          }
        },
      ),
      //convert
      SizedBox(
        width: 20,
      ),
      ElevatedButton(
        child: Text(
          'PDF',
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.black,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(15)),
        onPressed: () async {
          if (_last != Null) {
            await Text2Pdf.generatePdf(_last);
          }
        },
      ),
    ]),
  );
}
