

import 'package:flutter/material.dart';


class TaskDetail extends StatefulWidget {
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editable Text'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, controller.text);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: controller,
              decoration: InputDecoration(
                hintText: "Previous:  ${_extractExtraInfo(context)}",
                labelText: 'Rewrite task here',
                border: OutlineInputBorder(),
                icon: Icon(Icons.task),
                suffixIcon: _iconButton(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null
            ), 
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: Text('Done'),
            )],
        ),
      ),
    );
  }

  IconButton? _iconButton() {
    IconButton? ic;

    if (controller.text.isEmpty) {
      ic = null;
    } else {
      ic = IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            controller.clear();
          });
        },
      );
    }

    return ic;
  }

   String? _extractExtraInfo(BuildContext context) {
    final Object? arg = ModalRoute.of(context)?.settings.arguments;
    return arg as String?;
  }
}
