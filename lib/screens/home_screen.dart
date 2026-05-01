import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widget/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/add_task_screen.dart';
import '../widgets/achieved_tasks_widget.dart';
import '../widgets/high_priority_tasks_widget.dart';
import '../widgets/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username = 'null';
  String? motivation;
  String? userImagePath;

  List<TaskModel> tasks = [];
  int totalTask = 0;

  int totalDoneTasks = 0;

  double percent = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getUserName();
    _loadTask();
    _motivation();
  }

  void _calculatePercent() {
    totalTask = tasks.length;

    ///احنا بنلعب ع الطول في العناصر دي
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    //await Future.delayed(Duration(seconds: 5));
    final getStringtask = PreferencesManager().getString('tasks');

    ///String i can to swape the object
    if (getStringtask != null) {
      /// علشان ممكن لما بفتحه بيكون فاضي
      //القيم بتيجي dynamic بتحتاج احدد نوعها
      final finalGetObject = jsonDecode(getStringtask) as List<dynamic>;

      setState(() {
        ///هنملاالموديل من السطر ده بي الداتا
        tasks = finalGetObject
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculatePercent();

        ///السطر ده اختصار اني اللف عن عناصر اللسته كلها بشياكه
        isLoading = false;
      });
    }
  }

  void _getUserName() async {
    // final pref = await SharedPreferences.getInstance();
    setState(() {
      username = PreferencesManager().getString('username');
      userImagePath = PreferencesManager().getString('user_image');
      // username = pref.getString('username');
    });
  }

  void _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });
    final updatedTask = tasks
        ///بعمل تحديث الي الماب اللي شغال عليها
        .map((element) => element.toJson())
        .toList();

    ///مستخدمش هنا الفاكتوري كونستركتور لانه كانه بيحدث الداتا اللي بدخلها في صفحه الاد تاسك

    // await pref.setString('tasks', jsonEncode(updatedTask));
    await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasksss = [];
    if (id == null) return; //متعملش حاجه
    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasksss = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();

      tasksss.removeWhere((element) => element.id == id);
      setState(() {
        //العموميه
        tasks.removeWhere((task) => task.id == id);
      });

      ///ToDO:handel task
      final updatedTask = tasksss.map((element) => element.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  // void _deleteTask(int? id) async {
  //بهدلت الدنيا معايا
  //   if (id == null) return;
  //   setState(() {
  //     tasks.removeWhere((task) => task.id == id);
  //     _calculatePercent();
  //   });
  //
  //   ///ToDO:handel task
  //   final updatedTask = tasks.map((element) => element.toJson()).toList();
  //   await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  // }

  void _motivation() async {
    //final pref = await SharedPreferences.getInstance();
    setState(() {
      motivation = PreferencesManager().getString('motivation_guote');
      //motivation = pref.getString('motivation_guote') ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(
                        //   'assets/images/Vector (1).svg',
                        //   width: 42,
                        //   height: 42,
                        // ),
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundImage: userImagePath == null ? AssetImage(
                              'assets/images/WhatsApp Image 2026-03-20 at 3.32.43 PM.jpeg',
                            ) : FileImage(File(userImagePath!)),
                          ),
                        ),
                        SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Evening ,$username',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                motivation ??
                                    "One task at a time.One step\n closer.",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(Icons.light_mode),
                        //   color: Color(0xFFFFFCFC),
                        // ),
                      ],
                    ),
                    Text(
                      'Yuhuu ,Your work Is ',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'almost done !',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(width: 8),
                        CustomSvgPicture.withoutColor(
                          path:
                              'assets/images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg',
                          width: 32,
                          height: 32,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    AchievedTasksWidget(
                      percent: percent,
                      totalDoneTasks: totalDoneTasks,
                      totalTask: totalTask,
                    ),
                    SizedBox(height: 8),
                    HighPriorityTasksWidget(
                      tasks: tasks,
                      onTap: (bool? value, int? index) {
                        _doneTask(value, index);
                      },
                      refresh: () {
                        setState(() {
                          _loadTask();
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              isLoading
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(value: 20),
                      ),
                    )
                  : SliverTaskListWidget(
                      tasks: tasks,
                      onTap: (bool? value, int? index) {
                        _doneTask(value, index);

                        /// Function shared in project
                        // final isDone = pref.getString('isDone');
                        // if (isDone != null) {
                        //   tasks[index!].isDone = jsonDecode(isDone);
                        // }
                      },
                      emptyMessage: 'No Data',
                      onDelete: (int id) {
                        _deleteTask(id);
                      },
                      onEdit: () {
                        _loadTask();
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 167,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xFF15B86C),
          foregroundColor: Color(0xFFFFFCFC),
          label: Text(
            'Add New Task',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskScreen();
                },
              ),
            );
            // print(result);
            if (result != null && result == true) {
              _loadTask();

              /// اول ما يرجع بعمل لود تاسك
            }
          },
        ),
      ),
    );
  }
}
// if (task.isNotEmpty) دي اللي كانت حايشه علامه اللودنج
// isLoading?Center(
//   child: CircularProgressIndicator(
//     value: 20,
//   ),
// ) :TaskListWidget(
//   tasks: tasks,
//   onTap: (bool? value, int? index){
//     _doneTask(value, index);
//
//     /// Function shared in project
//     // final isDone = pref.getString('isDone');
//     // if (isDone != null) {
//     //   tasks[index!].isDone = jsonDecode(isDone);
//     // }
//   },
//   emptyMessage: 'No Data',
// ),

///TODO:ElevatedButton(
// // style: ElevatedButton.styleFrom(
// // // padding: EdgeInsets.zero,
// // foregroundColor: Color(0xFFFFFCFC),
// // fixedSize: Size(167, 40),
// // backgroundColor: Color(0xFF15B86C),
// // shape: RoundedRectangleBorder(
// // borderRadius: BorderRadiusGeometry.circular(100),
// // ),
// // ),
// // onPressed: () {},
// // child: Row(
// // children: [
// // Icon(Icons.add),
// // SizedBox(width: 8),
// // Text(
// // 'Add New Task',
// // style: TextStyle(
// // fontWeight: FontWeight.w500,
// // fontSize: 14,
// // ),
// // ),
// // ],
// // ),
// // ),

///--------------------------------------------------------------
///Spacer(),
// Align(
//   alignment: Alignment.bottomRight,
//   child: ElevatedButton.icon(
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) {
//             return AddTask();
//           },
//         ),
//       );
//     },
//     icon: Icon(Icons.add),
//
//     label: Text(
//       'Add New Task',
//       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
//     ),
//     style: ElevatedButton.styleFrom(
//       // padding: EdgeInsets.zero,
//       foregroundColor: Color(0xFFFFFCFC),
//       fixedSize: Size(167, 40),
//       backgroundColor: Color(0xFF15B86C),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadiusGeometry.circular(100),
//       ),
//     ),
//   ),
// ),

/// model use in first home screen
///
///  final tasks = finalGetOpJect.map((element) {
//         return TaskModele(taskName:element ['taskName'   كانها KEY بتاع Map],
//             taskDescription: element ['taskDescription'],
//             taskHighPriority: element ['isHighPriority']);
//       }).toList();     حولهالي الي لسته يا باشا

/// list view . builder

///------------------------------------------------------
///isLoading     /// loding == true
//                     ? Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       )
//                     :
