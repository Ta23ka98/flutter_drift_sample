// import 'package:flutter/material.dart';
// import 'package:flutter_drift_sample/src/models/entities/database/todo_entity.dart';
//
// class DriftSample extends StatelessWidget {
//   const DriftSample({Key? key, required this.database}) : super(key: key);
//
//   final MyDatabase database;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder(
//                 stream: database.watchEntries(),
//                 builder:
//                     (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   return ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return TextButton(
//                             onPressed: () async {
//                               await database.updateTodo(
//                                   snapshot.data![index], 'updated');
//                             },
//                             child: Text(snapshot.data![index].content));
//                       });
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                     child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       await database.addTodo("test");
//                     },
//                     child: const Text("add"),
//                   ),
//                 )),
//                 Expanded(
//                     child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: ElevatedButton(
//                       onPressed: () async {
//                         final list = await database.allTodoEntries;
//                         if (list.isNotEmpty) {
//                           await database.deleteTodo(list[list.length - 1]);
//                         }
//                       },
//                       child: const Text("remove")),
//                 )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
