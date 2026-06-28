import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/widget/custom_text_forme_field.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  ///TODO: DISPOSE THIS CONTROLLERS
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController taskNameController = .new();

  final TextEditingController taskDescription = .new();
  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Form(
            key: _key,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                //   Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {

                      final taskJson = PreferencesManager().getString('tasks');
                      /// edit in the model
                      List<dynamic> listTasks = [];

                      ///جيب القديمه ممكن ترجع بي نل مش مشكله
                      if (taskJson != null) {
                        listTasks = jsonDecode(taskJson);

                        ///swape to opject بيرجع
                      }
                      //add one task حطيتها تحت علشان محتاج  اللست تبقا متعرفعه علشان id
                      //object == map  more object ==name Json
                      TaskModel model = TaskModel(
                        id: listTasks.length + 1,
                        taskName: taskNameController.value.text,
                        taskDescription: taskDescription.value.text,
                        taskHighPriority: isHighPriority,
                      );
                      listTasks.add(model.toJson());

                      ///ده اللي استفدته من الموديل
                      // print('the list of after task $listTasks');
                      final taskEncode = jsonEncode(
                        listTasks,
                      ); //حولهالي استرنج علشان ابعتها
                      //  await pref.setString('tasks', taskEncode);
                      await PreferencesManager().setString('tasks', taskEncode);
                      Navigator.of(context).pop(true);

                      ///رجعني للصفحه اللي وراها ع طول
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFFFFFCFC),
                    backgroundColor: Color(0xFF15B86C),
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  icon: Icon(Icons.add, size: 18),
                  label: Text(
                    'Add Task',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// onPressed: () async {
// if (_key.currentState?.validate() ?? false) {
// final Map<String, dynamic> task = {
// "taskName": taskNameController.value.text,
// "taskDescription": taskDescription.value.text,
// "taskHighPriority": isHighPriority,
// };
// final pref = await SharedPreferences.getInstance();
// final taskswapSringEnCode = jsonEncode(task);    ///swap to string
// final setTaskEncode = await pref.setString('task', taskswapSringEnCode,);///اخزنها علشان لما احتاجها
///   كدا في حاله اني ببعت تاسك وحده
///---------------------------------------------------------------------------
// List<dynamic> listTasks = [];
// final taskJson= pref.getString('tasks');
// if(taskJson!=null){
// listTasks = jsonDecode(taskJson);
// }
// print('the list of after task $listTasks');
// listTasks.add(task);
// print('the list of pefore add to task $listTasks');
// // print(setTaskEncode);
// // print(task);
// // print(taskEnCode);
// }
// },

///-------------------------------------------------------------------
///textFormeField
///  TextFormField(
//                         //   // validator: (String? value) {
//                         //   //   if (value?.trim().isEmpty ?? false) {
//                         //   //     return "please enter the task ";
//                         //   //   } else
//                         //   //     return null;
//                         //   // },
//                         //   maxLines: 5,
//                         //   controller: taskDescription,
//                         //   cursorColor: Colors.white,
//                         //   style: TextStyle(color: Colors.white),
//                         //   decoration: InputDecoration(
//                         //     filled: true,
//                         //     fillColor: Color(0xFF282828),
//                         //     border: OutlineInputBorder(
//                         //       borderSide: BorderSide.none,
//                         //       borderRadius: BorderRadius.circular(20),
//                         //     ),
//                         //     hintText:
//                         //         "Finish onboarding UI and hand off to\n devs by Thursday.",
//                         //     hintStyle: TextStyle(
//                         //       color: Color(0xFF6D6D6D),
//                         //       fontSize: 16,
//                         //       fontWeight: FontWeight.w400,
//                         //     ),
//                         //   ),
//                         // ),
///--------------------------------------
// TextFormField(
//   style: TextStyle(color: Colors.white),
//   validator: (String? value) {
//     if (value?.trim().isEmpty ?? false) {
//       return "please enter the task ";
//     } else
//       return null;
//   },
//   controller: taskNameController,
//   cursorColor: Colors.white,
//   decoration: InputDecoration(
//     filled: true,
//     fillColor: Color(0xFF282828),
//     border: OutlineInputBorder(
//       borderSide: BorderSide.none,
//       borderRadius: BorderRadius.circular(16),
//     ),
//     hintText: "Finish UI design for login screen",
//     hintStyle: TextStyle(
//       color: Color(0xFF6D6D6D),
//       fontSize: 16,
//       fontWeight: FontWeight.w400,
//     ),
//   ),
// ),
