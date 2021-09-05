import 'package:flutter/material.dart';

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

class DoneOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO Usar ToggleOptions
    return Column(
      children: [Text('Nothing'), Text('Grey out'), Text('Delete')]
          .map((e) => ElevatedButton(onPressed: null, child: e))
          .toList(),
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
            style: TextStyle(fontSize: 18, color: Colors.grey),
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
