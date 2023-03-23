import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_drift_sample/main.dart';
import 'package:flutter_drift_sample/src/components/edit_task_dialog.dart';
import 'package:flutter_drift_sample/src/routes/app_routes.dart';
import 'package:flutter_drift_sample/src/services/local/app_database.dart';
import 'package:flutter_drift_sample/src/views/todo_list_page/parts/todo_list_item.dart';

import 'parts/add_task_list_tile.dart';

final isEditingProvider = StateProvider<bool>((ref) {
  return false;
});

final todoListProvider = StreamProvider<List<Todo>>((ref) {
  final localRepo = ref.read(localRepoProvider);
  final todoRepo = localRepo.todoRepo;
  return todoRepo.watchAllTodos();
});

class ToDoListPage extends ConsumerWidget {
  const ToDoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(isEditingProvider);
    final todoList = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDoリスト"),
        actions: [
          InkWell(
            onLongPress: () {
              final AppDatabase db = ref.read(databaseProvider);
              Navigator.pushNamed(context, AppRoutes.driftDbViewer,
                  arguments: db);
            },
            child: IconButton(
              icon: Icon(isEditing ? Icons.check : Icons.create_rounded),
              onPressed: () =>
                  ref.read(isEditingProvider.notifier).state = !isEditing,
            ),
          ),
        ],
      ),
      body: todoList.when(
        // エラー時
        error: (err, _) => Text(err.toString()),
        // 読み込み時
        loading: () => const Center(child: CircularProgressIndicator()),
        // データ受け取り時
        data: (data) {
          int itemCount = data.length;
          return ListView.builder(
            itemCount: isEditing ? itemCount + 1 : itemCount,
            itemBuilder: (context, index) {
              // フッター
              if (isEditing && index == itemCount) {
                return const AddTaskListTile(addEditMode: AddEditMode.add);
              }
              return TodoListItem(
                key: Key(index.toString()),
                index: index,
                todo: data[index],
              );
            },
          );
        },
      ),
    );
  }
}
