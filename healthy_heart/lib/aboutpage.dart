import 'dart:js' as js;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextSpan text(String text) {
  return TextSpan(
    text: text,
  );
}

TextSpan h1(String text) {
  return TextSpan(
    text: '$text\n\n',
    style: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextSpan h2(String text) {
  return TextSpan(
    text: '\n$text\n',
    style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextSpan link(String url) {
  return TextSpan(
    text: url,
    recognizer: new TapGestureRecognizer()..onTap = () => js.context.callMethod('open', [url, '_blank']),
    style: TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  );
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Flexible(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          h1('About'),
                          text('The purpose of this app is to help you maintain heart health and exercise daily. It has four tabs.\n'),
                          h2('Tab 1 - About'),
                          text('This is the tab you\'re on right now. It documents all the features of the app.\n'),
                          h2('Tab 2 - Exercise Reminders'),
                          text('This tab helps you set SMS reminders that will get sent by SMS to your phone. To create a reminder, click the "ADD EXERCISE REMINDER" button and fill out the fields in the form. To delete a reminder, click the red trash icon next to it.\n'),
                          h2('Tab 3 - Heart Rate Monitoring'),
                          text('Using a technique called rPPG (remote photoplethysmography), you can measure your heart rate through your webcam. To use it, you have to allow webcam permissions for this website. It may take a few seconds to start. The longer it runs and the more data it collects, the more accurate it is. Keep in mind that this should not be used as medical advice.\n'),
                          h2('Tab 4 - Information'),
                          text('This tab is straightforward; it gives you information about how to prevent heart disease.\n\n\nThis app was made for the STL Science Fair. The code for this app can be found at '),
                          link('https://github.com/shreyasm-dev/healthyheart'),
                          text('.'),
                        ],
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
