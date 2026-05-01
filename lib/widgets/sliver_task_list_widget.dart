import 'package:flutter/material.dart';
import 'package:tasky/core/widget/custom_check_box.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item_widget_in_list.dart';

class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int) onDelete;
  final Function onEdit;

  ///call Back Fun
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ///لو التاسك فاضيه حطلي نو داتا
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage ?? "No Data",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFFCFC),
                ),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
            sliver: SliverList.separated(
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
                  },
                  onEdit: () {
                    onEdit();
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
            ),
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
//             ///علشان لو مفيش دسكربشن يبقا ياباشا يجيب الكلا في النص
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
