import 'dart:html';
import 'package:flutter/material.dart';

class Reminder extends StatelessWidget {
  Reminder(this.reminder, this.deleteCallback, this.setStateX);
  final Map<String, String> reminder;
  final Function deleteCallback;
  final Function setStateX;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(reminder['name'] + ' (' + reminder['phone'] + ')'),
        IconButton(
          onPressed: () {
            deleteCallback(reminder['name'], reminder['phone']);
            setStateX(() {
              int i = 0;
              for (Map<String, String> reminderX in reminderList) {
                if (reminderX['name'] == reminder['name']) {
                  reminderList.removeAt(i);
                  window.localStorage.remove(reminderX['name']);
                  window.localStorage.remove(reminderX['name'] + reminderX['phone'] + '˛');
                  return;
                }

                i++;
              }
            });
          },
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

List<Map<String, String>> reminderList = [
  for (String key in window.localStorage.keys)
    if (key[key.length - 1] != '˛')
      {
        'name': key,
        'phone': window.localStorage[key + 'phone˛'],
      },
];

class RemindersPage extends StatefulWidget {
  RemindersPage(this.mainColor, this.callbackMain, this.deleteCallback);
  final MaterialColor mainColor;
  final Function callbackMain;
  final Function deleteCallback;

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height - (kToolbarHeight * 2))) / 2,
        children: [
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NewReminderDialog(widget.mainColor, widget.callbackMain, setState),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text('ADD EXERCISE REMINDER'),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: ListView(
              children: [
                Text(
                  'Click the "ADD EXERCISE REMINDER" to schedule a new SMS reminder',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                for (final Map<String, String> reminder in reminderList)
                  Reminder(reminder, widget.deleteCallback, setState),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewReminderDialog extends StatefulWidget {
  NewReminderDialog(this.mainColor, this.callbackMain, this.setStateX);
  final MaterialColor mainColor;
  final Function callbackMain;
  final Function setStateX;

  @override
  _NewReminderDialogState createState() => _NewReminderDialogState();
}

class _NewReminderDialogState extends State<NewReminderDialog> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  List<bool> days = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  final List<String> dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  bool isPM = true;
  int mins = 0;
  int hours = 12;

  void removeDialog() {
    Navigator.of(context).pop();
  }

  String getNameText() {
    return this.nameController.text;
  }

  String getPhoneText() {
    return this.phoneController.text;
  }

  Future<void> _dialog(String title, String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Okay',
                style: TextStyle(
                  color: widget.mainColor,
                ),
              ),
              onPressed: () {
                removeDialog();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.mainColor,
        title: Text('New Exercise Reminder'),
      ),
      body: Scrollbar(
        radius: Radius.circular(100),
        thickness: 7,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add a Reminder',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
                TextFormField(
                  maxLength: 100,
                  controller: nameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.directions_bike_rounded),
                    labelText: 'Reminder name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.mainColor),
                    ),
                  ),
                ),
                TextFormField(
                  maxLength: 100,
                  controller: phoneController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.directions_bike_rounded),
                    labelText: 'Phone number (SMS messages will be sent here)',
                    helperText: 'Format as XXXXXXXXXX',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: widget.mainColor),
                    ),
                  ),
                ),
                Text(
                  '\nShow the reminder on:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Wrap(
                  spacing: 15.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    for (var i = 0; i < 7; i++)
                      Row(
                        children: [
                          FilterChip(
                            onSelected: (bool value) {
                              setState(() {
                                days[i] = value;
                                if (!days.contains(true)) days[i] = true;
                              });
                            },
                            selected: days[i],
                            label: Text(dayNames[i]),
                            selectedColor: Colors.white,
                            checkmarkColor: widget.mainColor,
                            backgroundColor: Colors.white,
                            // activeColor: widget.mainColor,
                          ),
                        ],
                      )
                  ],
                ),
                Text(
                  '\nShow the reminder at:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    DropdownButton<int>(
                      value: hours,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      style: TextStyle(
                        color: widget.mainColor,
                      ),
                      underline: Container(
                        height: 2,
                        color: widget.mainColor,
                      ),
                      onChanged: (int newValue) {
                        setState(() {
                          hours = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<int>(
                          value: 12,
                          child: Text(
                            '12',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        for (var i = 0; i < 11; i++)
                          DropdownMenuItem<int>(
                            value: (i + 1),
                            child: Text(
                              (i + 1).toString().length == 2 ? (i + 1).toString() : '0' + (i + 1).toString(),
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      ' : ',
                      style: TextStyle(
                        color: widget.mainColor
                      )
                    ),
                    DropdownButton<int>(
                      value: mins,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      style: TextStyle(
                        color: widget.mainColor,
                      ),
                      underline: Container(
                        height: 2,
                        color: widget.mainColor,
                      ),
                      onChanged: (int newValue) {
                        setState(() {
                          mins = newValue;
                        });
                      },
                      items: [
                        for (var i = 0; i < 60; i++)
                          DropdownMenuItem<int>(
                            value: i,
                            child: Text(
                              i.toString().length == 2 ? i.toString() : '0' + i.toString(),
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text('   '),
                    DropdownButton<bool>(
                      value: isPM,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      style: TextStyle(
                        color: widget.mainColor,
                      ),
                      underline: Container(
                        height: 2,
                        color: widget.mainColor,
                      ),
                      onChanged: (bool newValue) {
                        setState(() {
                          isPM = newValue;
                        });
                      },
                      items: [
                        DropdownMenuItem<bool>(
                          value: true,
                          child: Text(
                            'PM',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: Text(
                            'AM',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '\n',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (getNameText().trim() == '' || getNameText().contains(RegExp('[^a-zA-Z0-9\' ]'))) {
                      _dialog('Error', 'Invalid reminder name (cannot be empty and has to only contain alphanumeric characters, spaces, and \')');
                    } else if (!new RegExp(r'^\d{10}$').hasMatch(getPhoneText())) {
                      _dialog('Error', 'Invalid phone number (format as XXXXXXXXXX)');
                    } else {
                      for (final Map<String, dynamic> element in reminderList) {
                        if (element['name'].toLowerCase() == getNameText().toLowerCase()) {
                          _dialog('Error', 'Reminder with name already exists');
                          return;
                        }
                      }

                      window.localStorage[getNameText().trim()] = '';
                      window.localStorage[getNameText().trim() + 'phone˛'] = getPhoneText();
                      widget.setStateX(() {
                        reminderList.add(
                          {
                            'name': getNameText().trim(),
                            'phone': getPhoneText(),
                          },
                        );
                      });

                      widget.callbackMain(
                        getNameText().trim(),
                        getPhoneText(),
                        hours,
                        mins,
                        isPM,
                        days,
                      );

                      removeDialog();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('ADD REMINDER'),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(widget.mainColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
