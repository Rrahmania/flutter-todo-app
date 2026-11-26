import 'package:flutter/material.dart';

import '../services/firestrore_service.dart';

class TodoDialog extends StatefulWidget{
  final FirestoreService firestoreService;
  const TodoDialog({
    super.key,
    required this.firestoreService
  });

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog>{
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose(){
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: const Text('Add Todo'),
      content: TextField(
        controller: _taskController,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Add new task..'),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final text = _taskController.text.trim();
            if (text.isNotEmpty) {
              await widget.firestoreService.addTodo(text);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}