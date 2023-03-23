import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_drift_sample/main.dart';
import 'package:flutter_drift_sample/src/services/local/app_database.dart';
import 'package:flutter_drift_sample/src/utils/showDialog.dart';
import 'package:flutter_drift_sample/src/views/todo_list_page/todo_list_page.dart';

class TodoListItem extends ConsumerWidget {
  const TodoListItem({super.key, required this.index, required this.todo});

  final int index;
  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localRepo = ref.read(localRepoProvider);
    final todoRepo = localRepo.todoRepo;

    final isEditing = ref.watch(isEditingProvider);
    return InkWell(
      onTap: isEditing
          ? () => showEditTaskDialog(
                context,
                index,
                todo,
              )
          : () {
              todoRepo
                  .updateTodo(todo.copyWith(isCompleted: !todo.isCompleted));
            },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: ListTile(
          title: Text(todo.title),
          trailing: isEditing
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    todoRepo.deleteTodoById(todo.id);
                  },
                )
              : todo.isCompleted
                  ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                  : null,
        ),
      ),
    );
  }
}
