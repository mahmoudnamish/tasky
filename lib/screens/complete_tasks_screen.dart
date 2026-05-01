import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

//import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> compliteTasks = [];
  bool isLoading = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    _loadingTask();
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
        compliteTasks.removeWhere((task) => task.id == id);
      });

      ///ToDO:handel task
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  void _loadingTask() async {
    setState(() {
      isLoading = true;
    });
    //final pref = await SharedPreferences.getInstance();
    // final getStringtask = pref.getString('tasks');
    final getStringtask = PreferencesManager().getString('tasks');
    if (getStringtask != null) {
      final finalGetObject = jsonDecode(getStringtask) as List<dynamic>;
      setState(() {
        compliteTasks = finalGetObject
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone)
            .toList();

        ///عملتها في نفس اللين
        /// tasks= tasks.where((element)=>element.isDone == false).toList();
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            "Completed Tasks",
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : TaskListWidget(
                    tasks: compliteTasks,
                    onTap: (bool? value, int? index) async {
                      //   final pref = await SharedPreferences.getInstance();
                      setState(() {
                        compliteTasks[index!].isDone = value ?? false;
                      });
                      // final updatedTask = tasks
                      //     ///بعمل تحديث الي الماب اللي شغال عليها
                      //     .map((element) => element.toJson())
                      //     .toList();
                      ///--------------------------------------------------
                      // final allData = pref.getString('tasks');
                      final allData = PreferencesManager().getString('tasks');
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List<dynamic>)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();

                        ///----------------------------
                        ///عايز اعرف الاندكس بتاعه في الاول تاسك اللي فيها
                        final newIndex = allDataList.indexWhere(
                          (element) => element.id == compliteTasks[index!].id,

                          ///ساويه بي الاندكس بتاع اللسته دي يا باشا
                        );

                        allDataList[newIndex] = compliteTasks[index!];

                        /// سويثت الاندس بتاع اللسته الكبيره بي الاندكس بتاع اللسته دي
                        //  pref.setString('tasks', jsonEncode(allDataList));
                        await PreferencesManager().setString(
                          'tasks',
                          jsonEncode(allDataList),
                        );
                        _loadingTask();
                      }
                    },
                    emptyMessage: 'No Task Found',
                    onDelete: (int id) {
                      _deleteTask(id);
                    },
                    onEdit: () {
                      _loadingTask();
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
