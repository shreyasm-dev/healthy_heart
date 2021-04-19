import 'dart:convert';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy_heart/reminderspage.dart';
import 'package:healthy_heart/heartratepage.dart';
import 'package:healthy_heart/infopage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  runApp(App());
}

List<int> twelveTo24(hours, mins, pm) {
  if (hours == 12) {
    hours = 0;
  }

  if (pm) {
    hours = hours + 12;
  }

  return [hours, mins];
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Map<int, Color> colors = {
    50: Color.fromRGBO(136, 14, 79, 0.1),
    100: Color.fromRGBO(136, 14, 79, 0.2),
    200: Color.fromRGBO(136, 14, 79, 0.3),
    300: Color.fromRGBO(136, 14, 79, 0.4),
    400: Color.fromRGBO(136, 14, 79, 0.5),
    500: Color.fromRGBO(136, 14, 79, 0.6),
    600: Color.fromRGBO(136, 14, 79, 0.7),
    700: Color.fromRGBO(136, 14, 79, 0.8),
    800: Color.fromRGBO(136, 14, 79, 0.9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: MaterialColor(0xffea4af0, colors),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.alarm_rounded)),
                Tab(icon: Icon(Icons.bar_chart_rounded)),
                Tab(icon: Icon(Icons.info_outline_rounded)),
              ],
            ),
            title: Row(
              children: [
                Spacer(),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.favorite_border_rounded),
                      ),
                      TextSpan(
                        text: ' Healthy Heart',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                    ]
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              RemindersPage(
                MaterialColor(0xffea4af0, colors),
                (String name, String number, int hours, int mins, bool pm, List<bool> days) {
                  final time24 = twelveTo24(hours, mins, pm);
                  http.post(
                    Uri(
                      path: '/reminder',
                    ),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode({
                      'name': name,
                      'number': number,
                      'hours': time24[0],
                      'mins': time24[1],
                      'pm': pm.toString(),
                      'days': days,
                    }),
                  );
                },
                (String name, String number) {
                  http.post(
                    Uri(
                      path: '/delete-reminder',
                    ),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode({
                      'name': name,
                      'number': number,
                    }),
                  );
                },
              ),
              HeartratePage(),
              InfoPage(),
            ],
          ),
        ),
      ),
    );
  }
}
