import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widget/custom_check_box.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screens/high_priority_tasks_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  List<TaskModel> tasks = [];
  final Function(bool?, int?) onTap;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      width: double.infinity,
      //margin:EdgeInsets.all(16) , // بيعمل مساحه من برا
      padding: EdgeInsets.all(16),

      // بيعمل مساحه من جوا
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'High Priority Tasks',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),

                ///------------------------------------------------
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      //لو اكبر من اتنين
                      tasks.reversed.where((e) => e.taskHighPriority).length > 2
                      ? 2
                      : tasks.reversed
                            .take(2)
                            ///خد  اتنين بس
                            .where((e) => e.taskHighPriority)
                            .length,

                  ///-------------------------------------------------
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks.reversed.take(2).where((e) => e.taskHighPriority).toList()[index]; // يبقا انا جبتله اللسته والاندكس بتاعها بتاع الصفحه دي
                    return Row(
                      children: [
                        CustomCheckBox(
                          onChanged: (bool? value) {
                            final index = tasks.indexWhere((element) => element.id == task.id, //سوينا الاندكس الرئيسيه بي الاندكس بتاعت الصفحه دي
                            );
                            ///علشان احطها في الاون تاب يا باشا
                            ///ابديت ع الداتا في الشرد برفرنس
                            onTap(value, index);
                            //ببعتلها الاندكس العممومي من برا والفاليو
                            ///علشان مش هحط اللوجك هنا
                          },
                          value: task.isDone,
                        ),
                        // Checkbox(
                        //   activeColor: Color(0xFF15B86C),
                        //   value: task.isDone,
                        //   ///عايز هنا bool true false
                        //   onChanged: (bool? value) {
                        //     final index = tasks.indexWhere(
                        //       (element) => element.id == task.id, //سوينا الاندكس الرئيسيه بي الاندكس بتاعت الصفحه دي
                        //     );
                        //
                        //     ///علشان احطها في الاون تاب يا باشا
                        //     ///ابديت ع الداتا في الشرد برفرنس
                        //     onTap(value, index);
                        //
                        //     ///علشان مش هحط اللوجك هنا
                        //   },
                        //   // shape: RoundedRectangleBorder(
                        //   //   borderRadius: BorderRadius.circular(4),
                        //   //
                        //   // ),
                        // ),
                        Flexible(
                          child: Text(
                            task.taskName,
                            style: task.isDone
                                ? Theme.of(context).textTheme.titleLarge
                                : Theme.of(context).textTheme.titleMedium,
                            // style: TextStyle(
                            //   color: task.isDone
                            //       ? Color(0xFFA0A0A0)
                            //       : Color(0xFFFFFCFC),
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.w400,
                            //   decoration: task.isDone
                            //       ? TextDecoration.lineThrough
                            //       : TextDecoration.none,
                            //   decorationColor: Color(0xFFA0A0A0),
                            // ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                // ...tasks.reversed.take(2).where((e) => e.taskHighPriority).map((
                //   element,
                // ) {
                //   return Row(
                //     children: [
                //       Checkbox(
                //         activeColor: Color(0xFF15B86C),
                //         value: element.isDone,
                //
                //         ///عايز هنا bool true false
                //         onChanged: (bool? value) {
                //           final index = tasks.indexWhere(
                //             (e) => e.id == element.id,
                //           );
                //
                //           ///علشان احطها في الاون تاب يا باشا
                //           ///ابديت ع الداتا في الشرد برفرنس
                //           onTap(value, index);
                //
                //           ///علشان مش هحط اللوجك هنا
                //         },
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(4),
                //         ),
                //       ),
                //       Flexible(
                //         child: Text(
                //           element.taskName,
                //           style: TextStyle(
                //             color: element.isDone
                //                 ? Color(0xFFA0A0A0)
                //                 : Color(0xFFFFFCFC),
                //             fontSize: 16,
                //             fontWeight: FontWeight.w400,
                //             decoration: element.isDone
                //                 ? TextDecoration.lineThrough
                //                 : TextDecoration.none,
                //             decorationColor: Color(0xFFA0A0A0),
                //           ),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //     ],
                //   );
                // }),
              ],
            ),
          ),
          Container(
            // margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(12),
            height: 65,
            width: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeController.isDark()
                    ? Color(0xFF6E6E6E)
                    : Color(0xFFD1DAD6),
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HighPriorityTasksScreen();
                    },
                  ),
                );
                refresh();
              },
              child: SvgPicture.asset(
                "assets/images/arrow-up-right.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  ThemeController.isDark()
                      ? Color(0xFFC6C6C6)
                      : Color(0xFF3A4640),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
