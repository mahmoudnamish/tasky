import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import '../../models/task_model.dart';
import '../../widgets_shared_component/task_list_widget.dart';


class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});

  @override
  State<HighPriorityTasksScreen> createState() =>
      _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
  List<TaskModel> highPriorityTasks = [];

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
    //final pref = await SharedPreferences.getInstance();
    //final getStringtask = pref.getString('tasks');
    final getStringtask = PreferencesManager().getString('tasks');
    if (getStringtask != null) {
      final finalGetObject = jsonDecode(getStringtask) as List<dynamic>;
      setState(() {
        highPriorityTasks = finalGetObject
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.taskHighPriority)
            .toList();
        //    highPriorityTasks = highPriorityTasks.reversed.toList();

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
        highPriorityTasks.removeWhere((task) => task.id == id);
      });

      ///ToDO:handel task
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HighPriorityTasksScreen")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : TaskListWidget(
              tasks: highPriorityTasks,
              onTap: (value, index) async {
                setState(() {
                  highPriorityTasks[index!].isDone = value ?? false;
                });
                // final pref = await SharedPreferences.getInstance();
                ///--------------------------------------------------
                // final allData = pref.getString('tasks');
                final allData = PreferencesManager().getString('tasks');
                if (allData != null) {
                  List<TaskModel> allDataList =
                      (jsonDecode(allData) as List<dynamic>)
                          .map((element) => TaskModel.fromJson(element))
                          .toList();
                  //علشان املاء  الموديل
                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == highPriorityTasks[index!].id,
                  );

                  allDataList[newIndex] = highPriorityTasks[index!];
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
              },
              onEdit: () {
                _loadingTask();
              },
            ),
    );
  }
}
