import 'package:flutter/material.dart';
import 'package:flutter_drift_sample/src/components/edit_task_dialog.dart';
import 'package:flutter_drift_sample/src/services/local/app_database.dart';

Future<String?> showAddTaskDialog(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return EditTaskDialog.addTask();
    },
  );
}

Future<String?> showEditTaskDialog(
  BuildContext context,
  int index,
  Todo todo,
) async {
  return await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return EditTaskDialog.editTask(index, todo);
    },
  );
}
