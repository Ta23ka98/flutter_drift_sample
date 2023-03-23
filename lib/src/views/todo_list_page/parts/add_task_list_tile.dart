import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_drift_sample/src/components/edit_task_dialog.dart';
import 'package:flutter_drift_sample/src/utils/showDialog.dart';

class AddTaskListTile extends ConsumerWidget {
  const AddTaskListTile({super.key, required this.addEditMode});

  final AddEditMode addEditMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        switch (addEditMode) {
          case AddEditMode.add:
            showAddTaskDialog(context);
            break;
          case AddEditMode.edit:
            break;
          default:
            throw Exception('Invalid addEditMode: $addEditMode');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: const ListTile(
          title: Text("タスクを追加"),
          leading: Icon(Icons.add),
        ),
      ),
    );
  }
}
