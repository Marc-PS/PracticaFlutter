import 'package:flutter/material.dart';
import 'package:gsd_app/settings_drawer.dart';
import 'package:gsd_app/task_widget.dart';
import 'package:gsd_domain/gsd_domain.dart';

void main() {
  // Añadir datos chorras al repo
  addTestDataToRepo();

  // Arrancar la UI
  runApp(GSDApp());
}

void addTestDataToRepo() {
  for (int i = 0; i < 120; i++) {
    if (i.isEven) {
      TaskRepository.shared.toDo('Somehting I should do $i');
    } else {
      TaskRepository.shared.done('Some finished task $i');
    }
  }
}

class GSDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GSD',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => TaskRepository.shared.toDo('Una nueva tarea'),
          child: Icon(Icons.add),
        ),
        drawer: SettingsDrawer(),
        appBar: AppBar(
          title: Text('GSD'),
        ),
        body: TaskListWidget(
          model: TaskRepository.shared,
        ),
      ),
    );
  }
}
