import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets_shared_component/task_item_widget_in_list.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.emptyMessage,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function( int) onDelete;
  final Function onEdit;

  ///call Back Fun
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ///لو التاسك فاضيه حطلي نو داتا
        ? Center(
            child: Text(
              emptyMessage ?? "No Data",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 50),

            ///علشان اخر عنصر اقدر اشوفه
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidgetInList(
                modele: tasks[index],
                onChanged: (bool? value) {
                  onTap(value, index);
                },
                onDelete: (int id) {
                  onDelete(id);
                }, onEdit: (){
                 onEdit();
              },
              );

              ///---------------كان هنا في كود
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}

// return Container(
//   alignment: Alignment.center,
//   height: 56,
//   width: MediaQuery.of(context).size.width,
//
//   ///double.infinity
//   decoration: BoxDecoration(
//     color: Color(0xFF282828),
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: Row(
//     children: [
//       SizedBox(width: 8),
//       CustomCheckBox(onChanged: (bool? value) {
//         ///ابديت ع الداتا في الشرد برفرنس
//         onTap(value, index);
//       }, value: tasks[index].isDone),
//       // Checkbox(
//       //   activeColor: Color(0xFF15B86C),
//       //   value: tasks[index].isDone,
//       //   onChanged: (bool? value) {
//       //     ///ابديت ع الداتا في الشرد برفرنس
//       //     onTap(value, index);
//       //   },
//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.circular(4),
//       //   ),
//       // ),
//       SizedBox(width: 16),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               tasks[index].taskName,
//               style: TextStyle(
//                 color: tasks[index].isDone
//                     ? Color(0xFFA0A0A0)
//                     : Color(0xFFFFFCFC),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 decoration: tasks[index].isDone
//                     ? TextDecoration.lineThrough
//                     : TextDecoration.none,
//                 decorationColor: Color(0xFFA0A0A0),
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             if (tasks[index].taskDescription.trim().isNotEmpty)
//               ///علشان لو مفيش دسكربشن يبقا ياباشا يجيب الكلا في النص
//               Text(
//                 tasks[index].taskDescription,
//                 style: TextStyle(
//                   color: tasks[index].isDone
//                       ? Color(0xFFA0A0A0)
//                       : Color(0xFFFFFCFC),
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   decoration: tasks[index].isDone
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                   decorationColor: Color(0xFFA0A0A0),
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//           ],
//         ),
//       ),
//       IconButton(
//         color: tasks[index].isDone
//             ? Color(0xFFA0A0A0)
//             : Color(0xFFC6C6C6),
//         onPressed: () {},
//         icon: Icon(Icons.more_vert),
//       ),
//     ],
//   ),
// );
