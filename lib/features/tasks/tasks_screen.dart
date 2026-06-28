import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

import '../../widgets_shared_component/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadingTask();
  }

  void _loadingTask() async {
    setState(() {
      isLoading = true;
    });
    final getStringtask = PreferencesManager().getString('tasks');
    if (getStringtask != null) {
      final finalGetObject = jsonDecode(getStringtask) as List<dynamic>;
      setState(() {
        todoTasks = finalGetObject
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == false)
            .toList();

        ///عملتها في نفس اللين
        // tasks= tasks.where((element)=>element.isDone == false).toList();
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;
    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((element) => element.id == id);
      setState(() {
        todoTasks.removeWhere((task) => task.id == id);
      });

      ///ToDO:handel task
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  // void _deleteTask(int? id) async {
  //   if (id == null) return;
  //   setState(() {
  //     todoTasks.removeWhere((task) => task.id == id);
  //   });
  //
  //   ///ToDO:handel task
  //   final updatedTask = todoTasks.map((element) => element.toJson()).toList();
  //   await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : TaskListWidget(
                    tasks: todoTasks,
                    onTap: (value, index) async {
                      ///هنا بقا اللقطه
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });
                      // final pref = await SharedPreferences.getInstance();
                      // final updatedTask = tasks
                      //     ///بعمل تحديث الي الماب اللي شغال عليها
                      //     .map((element) => element.toJson())
                      //     .toList();
                      //الكلام ده عمل غلط
                      ///--------------------------------------------------
                      final allData = PreferencesManager().getString('tasks');
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List<dynamic>)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
                        //علشان املاء  الموديل

                        ///----------------------------
                        final newIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );

                        ///جبت الاندكس بتاع االلست اللي في الموديل عن طريق id

                        allDataList[newIndex] = todoTasks[index!];
                        // pref.setString('tasks', jsonEncode(allDataList));
                        await PreferencesManager().setString(
                          'tasks',
                          jsonEncode(allDataList),
                        );
                        _loadingTask();
                      }

                      // final isDone = pref.getString('isDone');
                      // if (isDone != null) {
                      //   tasks[index!].isDone = jsonDecode(isDone);
                      // }
                    },
                    emptyMessage: 'No Task Found',
                    onDelete: (int id) {
                      _deleteTask(id);
                    }, onEdit: (){
                      _loadingTask();
            },
                  ),
          ),
        ),
      ],
    );
  }
}

//
// task.isEmpty    ///لو التاسك فاضيه حطلي نو داتا
// ? Center(
// child: Text(
// "No Data",
// style: TextStyle(
// fontSize: 24,
// fontWeight: FontWeight.w400,
// color: Color(0xFFFFFCFC),
// ),
// ),
// )
//     :
// //     ? Center(
// //   child: CircularProgressIndicator(color: Colors.white),
// // ):
// ListView.separated(
// padding: EdgeInsets.only(bottom: 50),
//
// ///علشان اخر عنصر اقدر اشوفه
// itemCount: task.length,
// itemBuilder: (BuildContext context, int index) {
// return Container(
// alignment: Alignment.center,
// height: 56,
// width: MediaQuery.of(context).size.width,
//
// ///double.infinity
// decoration: BoxDecoration(
// color: Color(0xFF282828),
// borderRadius: BorderRadius.circular(20),
// ),
// child: Row(
// children: [
// SizedBox(width: 8),
// Checkbox(
// activeColor: Color(0xFF15B86C),
// value: task[index].isDone,
// onChanged: (bool? value) async {
// ///ابديت ع الداتا في الشرد برفرنس
// final pref =
// await SharedPreferences.getInstance();
// setState(() {
// task[index].isDone = value ?? false;
// });
// final updatedTask = task
// ///بعمل تحديث الي الماب اللي شغال عليها
//     .map((element) => element.toJson())
//     .toList();
// pref.setString(
// 'tasks',
// jsonEncode(updatedTask),
// );
//
// final isDone = pref.getString('isDone');
// if (isDone != null) {
// task[index].isDone = jsonDecode(isDone);
// }
// },
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(4),
// ),
// ),
// SizedBox(width: 16),
// Expanded(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(
// task[index].taskName,
// style: TextStyle(
// color: task[index].isDone
// ? Color(0xFFA0A0A0)
//     : Color(0xFFFFFCFC),
// fontSize: 16,
// fontWeight: FontWeight.w400,
// decoration: task[index].isDone
// ? TextDecoration.lineThrough
//     : TextDecoration.none,
// decorationColor: Color(0xFFA0A0A0),
// ),
// maxLines: 1,
// overflow: TextOverflow.ellipsis,
// ),
// if (task[index].taskDescription
//     .trim()
//     .isNotEmpty)
// ///علشان لو مفيش دسكربشن يبقا ياباشا يجيب الكلا في النص
// Text(
// task[index].taskDescription,
// style: TextStyle(
// color: task[index].isDone
// ? Color(0xFFA0A0A0)
//     : Color(0xFFFFFCFC),
// fontSize: 16,
// fontWeight: FontWeight.w400,
// decoration: task[index].isDone
// ? TextDecoration.lineThrough
//     : TextDecoration.none,
// decorationColor: Color(0xFFA0A0A0),
// ),
// maxLines: 1,
// overflow: TextOverflow.ellipsis,
// ),
// ],
// ),
// ),
// IconButton(
// color: task[index].isDone
// ? Color(0xFFA0A0A0)
//     : Color(0xFFC6C6C6),
// onPressed: () {},
// icon: Icon(Icons.more_vert),
// ),
// ],
// ),
// );
// },
// separatorBuilder: (BuildContext context, int index) {
// return SizedBox(height: 8);
// },
// ),

//------------------------------------------------
//     :isLoading
// /// loding == true
// ? Center(child: CircularProgressIndicator(color: Colors.white))
