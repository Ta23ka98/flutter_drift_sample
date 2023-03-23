import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_drift_sample/main.dart';
import 'package:flutter_drift_sample/src/services/local/app_database.dart';

enum AddEditMode {
  add,
  edit,
}

class EditTaskDialog extends ConsumerWidget {
  const EditTaskDialog({
    super.key,
    required this.addEditMode,
    this.todo,
    required this.textEditingController,
  });

  final AddEditMode addEditMode;
  final Todo? todo;
  final TextEditingController textEditingController;

  factory EditTaskDialog.addTask() {
    return EditTaskDialog(
      addEditMode: AddEditMode.add,
      textEditingController: TextEditingController(),
    );
  }

  factory EditTaskDialog.editTask(int index, Todo todo) {
    return EditTaskDialog(
      addEditMode: AddEditMode.edit,
      todo: todo,
      textEditingController: TextEditingController(text: todo.title),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localRepo = ref.read(localRepoProvider);
    final todoRepo = localRepo.todoRepo;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AlertDialog(
        title: (() {
          switch (addEditMode) {
            case AddEditMode.add:
              return const Text("タスクを追加");
            case AddEditMode.edit:
              return const Text("タスクを編集");
            default:
              throw Exception('Invalid addEditMode: $addEditMode');
          }
        })(),
        content: TextField(
          keyboardType: TextInputType.text,
          controller: textEditingController,
          decoration: const InputDecoration(hintText: "タスクを入力"),
          enabled: true,
          maxLength: 20,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
        ),
        actions: <Widget>[
          // ボタン領域
          TextButton(
            child: const Text("キャンセル"),
            onPressed: () => Navigator.pop(context, "キャンセル"),
          ),
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              String textValue = textEditingController.text;
              switch (addEditMode) {
                case AddEditMode.add:
                  TodosCompanion newTodo = TodosCompanion(
                    title: Value(textValue),
                    isCompleted: const Value(false),
                  );
                  todoRepo.insertTodo(newTodo);
                  break;
                case AddEditMode.edit:
                  todoRepo.updateTodo(todo!.copyWith(title: textValue));
                  break;
                default:
                  throw Exception('Invalid addEditMode: $addEditMode');
              }
              Navigator.pop(context, "OK");
            },
          ),
        ],
      ),
    );
  }
}
