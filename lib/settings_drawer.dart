

import 'package:flutter/material.dart';
import 'package:gsd_app/domain/user_preferences.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsHeader(),
          DoneHeader(),
          DoneOptions(),
        ],
      ),
    );
  }
}

class DoneOptions extends StatefulWidget {
  @override
  _DoneOptionsState createState() => _DoneOptionsState();
}

class _DoneOptionsState extends State<DoneOptions> {
  List<bool> _selections =  [true, false, false];
 
  String? chosen;

  static const String kOptionTextNothing = 'Nothing'; //(Default)
  static const String kOptionTextCrossOut = 'Cross out';
  static const String kOptionTextDelete = 'Delete';
  static const String kOptionTextDeleteAll = 'AllDelete';

   Map<int, String> doneSelectedOptions = {
    0: kOptionTextNothing,
    1: kOptionTextCrossOut,
    2: kOptionTextDelete,
  };

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(

        isSelected: _selections,
        onPressed: (int index) async {
          setState(() {
            for (int buttonIndex = 0; buttonIndex < _selections.length; buttonIndex++) {
              if (buttonIndex == index) {
                _selections[buttonIndex] = true;
                chosen = doneSelectedOptions[buttonIndex];
              } else {
                _selections[buttonIndex] = false;
              }
            }
          });
          if (chosen == kOptionTextDelete) {
            chosen = await showDialog(context: context, builder: createDialog);
          }
          UserPreferences.setUserDonePreferences(chosen!);
        },
        direction: Axis.vertical,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nothing"),
              Container(width: 8),
              Icon(Icons.add_task_sharp),
            ],
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Grey style"),
              Container(width: 8),
              Icon(Icons.format_paint_sharp),
            ],
          ),  
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Erase task"),
              Container(width: 8),
              Icon(Icons.delete_forever),
            ],
          ), 
        ],
      
    );
  }
  Widget createDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Atention user'),
      content: Text('Do yo want to delete all tasks from the repository?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('YES'),
              onPressed: () {
                Navigator.pop(context, kOptionTextDeleteAll);
              },
            ),
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.pop(context, kOptionTextDelete);
              },
            )
          ],
        ),
      ],
    );
  }
}



class DoneHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Icon(Icons.done, size: 30),
          SizedBox(
            width: 10,
          ),
          Text(
            'What to do with "done" tasks?',
            style: TextStyle(fontSize: 18),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Row(
        children: const [
          Icon(Icons.settings, size: 64, color: Colors.white),
          SizedBox(
            width: 15,
          ),
          Text(
            'Settings',
            style: TextStyle(fontSize: 42, color: Colors.white),
          )
        ],
      ),
    );
  }
}
