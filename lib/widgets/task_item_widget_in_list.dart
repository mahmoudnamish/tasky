import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_item_actions_enum.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widget/custom_text_forme_field.dart';
import 'package:tasky/models/task_model.dart';

import '../core/services/preferences_manager.dart';
import '../core/widget/custom_check_box.dart';

class TaskItemWidgetInList extends StatelessWidget {
  TaskItemWidgetInList({
    super.key,
    required this.modele,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel modele;

  // List<TaskModel>tasks = [];
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      width: MediaQuery.of(context).size.width,

      ///double.infinity
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xFFD1DAD6),
          // color: ThemeController.themeNotifier.value == ThemeMode.light
          //     ? Color(0xFFD1DAD6)
          //     : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCheckBox(
            value: modele.isDone,
            onChanged: (bool? value) {
              ///ابديت ع الداتا في الشرد برفرنس
              // onTap(value, index);
              onChanged(value);
            },
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  modele.taskName,
                  style: modele.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (modele.taskDescription.trim().isNotEmpty)
                  ///علشان لو مفيش دسكربشن يبقا ياباشا يجيب الكلا في النص
                  Text(
                    modele.taskDescription,
                    style: modele.isDone
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            itemBuilder: (BuildContext context) =>
                TaskItemActionsEnum.values.map((e) {
                  return PopupMenuItem(child: Text(e.name), value: e);
                }).toList(),

            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (modele.isDone ? Color(0xFFA0A0A0) : Color(0xFFC6C6C6))
                  : (modele.isDone ? Color(0xFF6A6A6A) : Color(0xFF3A4640)),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
                case TaskItemActionsEnum.edit:
                  final resuilt = await _showModalBottomSheet(context, modele);
                  if ( resuilt == true) {
                    onEdit();
                  }

                case TaskItemActionsEnum.markAsDon:
                  if (modele.isDone) {
                    onChanged(false);
                  } else {
                    onChanged(true);
                  }
              }
            },
          ),
        ],
      ),
    );
  }

  ///TODO: context not public   context my own of puilder method
  _showAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        ///TODO:context my own of build widget call back fn
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text(
            "Are you sure you want to delete this task",
            style: TextStyle(fontSize: 12),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(modele.id);
                Navigator.pop(context);
              },
              child: Text('Delete'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showModalBottomSheet(context, TaskModel model)async {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescription = TextEditingController(
      text: model.taskDescription,
    );
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    bool isHighPriority = model.taskHighPriority;
    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Form(
              key: _key,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormeField(
                                title: 'Task Name',
                                controle: taskNameController,
                                hintText: "Finish UI design for login screen",
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? false) {
                                    return "please enter the task ";
                                  } else
                                    return null;
                                },
                              ),

                              SizedBox(height: 20),
                              CustomTextFormeField(
                                title: 'Task Description',
                                controle: taskDescription,
                                hintText:
                                    "Finish onboarding UI and hand off to\n devs by Thursday.",
                                maxLine: 5,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'High Priority',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFFFFCFC),
                                    ),
                                  ),
                                  Switch(
                                    value: isHighPriority,
                                    onChanged: (value) {
                                      setState(() {
                                        isHighPriority = value;
                                      });
                                    },
                                    //activeTrackColor: Color(0xFF15B86C),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        onPressed: () async {
                          if (_key.currentState?.validate() ?? false) {
                            final taskJson = PreferencesManager().getString(
                              'tasks',
                            );

                            /// edit in the model
                            List<dynamic> listTasks = [];

                            ///جيب القديمه ممكن ترجع بي نل مش مشكله
                            if (taskJson != null) {
                              listTasks = jsonDecode(taskJson);

                              ///swape to opject بيرجع
                            }
                            TaskModel newModel = TaskModel(
                              id: model.id,
                              taskName: taskNameController.value.text,
                              taskDescription: taskDescription.value.text,
                              taskHighPriority: isHighPriority,
                              isDone: model.isDone,
                            );
                            //listTasks.add(newModel.toJson());
                            // مودتهاش الي الموديل علشان اوديها كي وفليو
                            //انا استخدمتها هنا ديركت
                            final item = listTasks.firstWhere((e) {
                              return e['id'] ==
                                  model
                                      .id; //=> model.id بتاع الصفحه دي خلي بالك
                            });
                            final int index = listTasks.indexOf(item);

                            listTasks[index] = newModel;

                            ///ده اللي استفدته من الموديل
                            // print('the list of after task $listTasks');
                            final taskEncode = jsonEncode(
                              listTasks,
                            ); //حولهالي استرنج علشان ابعتها
                            await PreferencesManager().setString(
                              'tasks',
                              taskEncode,
                            );
                            Navigator.of(context).pop(true);

                            ///رجعني للصفحه اللي وراها ع طول
                          }
                        },
                        icon: Icon(Icons.edit, size: 18),
                        label: Text(
                          'Edit Task',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
