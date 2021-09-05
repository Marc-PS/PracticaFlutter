import 'package:flutter/material.dart';
import 'package:gsd_app/domain/user_preferences.dart';
import 'package:gsd_app/task_detail.dart';
import 'package:gsd_domain/gsd_domain.dart';
import 'package:mow/mow.dart';

class TaskListWidget extends ModelWidget<TaskRepository> {
  TaskListWidget({required TaskRepository model, Key? key})
      : super(model: model, key: key);
  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends ObserverState<TaskRepository, TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: TaskRepository.shared.length,
      itemBuilder: (context, index) {
        return TaskWidget(
          model: TaskRepository.shared[index],
          index: index,
        );
      },
    );
  }
}

class TaskWidget extends ModelWidget<Task> {
  late final int index;

  TaskWidget({required Task model, required int index, Key? key})
      : index = index,
        super(model: model, key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends ObserverState<Task, TaskWidget> {
  late BuildContext _currentContext;
  //String _pref = UserPreferences.getUserPreferences();
  
  // Lifecycle
  void _onCheckboxTap(bool? value) {
    final bool newValue = value ?? false;
    widget.model.state = newValue ? TaskState.done : TaskState.toDo;
  }


  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    
    return Dismissible(
      confirmDismiss: _confirmDismiss,
      background: DeleteTaskBackground(alignment: MainAxisAlignment.start),
      secondaryBackground:
          DeleteTaskBackground(alignment: MainAxisAlignment.end),
      onDismissed: _deleteTask,
      key: UniqueKey(),
      child: Card(
        child: ListTile(
          title: Text(widget.model.description),
          onTap: () async {
            final String? editedText = await Navigator.of(context).push<String>(
              MaterialPageRoute(
                settings: RouteSettings(arguments: widget.model.description),
                builder: (context) => TaskDetail(),
                ),
            );

          _displayNewTask(context, editedText);
          
        
          },
          leading: Checkbox(
            value: widget.model.state == TaskState.done,
            onChanged: _onCheckboxTap,
          ),
        ),
      ),
    );
  }

   void _displayNewTask(BuildContext context, Object? val) {
    if (val != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This is what I got back: $val'),
        ),
      );
    }
    
  }

  // Handlers
  Future<bool?> _confirmDismiss(DismissDirection direction) async {
    // una referencia al scaffoldmessenger
    // decirle que muestre un snackbar
    // crear un configurar una y mostrarla
    ScaffoldMessenger.of(_currentContext).showSnackBar(
      SnackBar(
        action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              print('Action Pressed');
            }),
        content: Text('Note: ${widget.model.description} has been deleted'),
        duration: Duration(seconds: 6),
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        behavior: SnackBarBehavior.floating,
        width: 288.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );

    return true;
  }

  

  void _deleteTask(DismissDirection direction) {
    // Eliminar la tarea del repo.
    final int oldLength = TaskRepository.shared.length;
    TaskRepository.shared.removeAt(widget.index);
    assert(TaskRepository.shared.length == oldLength - 1);
  }
}

class DeleteTaskBackground extends StatelessWidget {
  late final MainAxisAlignment alignment;
  DeleteTaskBackground({required MainAxisAlignment alignment})
      : alignment = alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[600],
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: alignment,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              'Delete',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
