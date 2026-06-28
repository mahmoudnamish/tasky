import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasksWidget extends StatelessWidget {
  AchievedTasksWidget({
    super.key,
    required this.totalTask,
    required this.totalDoneTasks,
    required this.percent,
  });

  int totalTask = 0;

  int totalDoneTasks = 0;

  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 72,
      width: MediaQuery.of(context).size.width,

      ///doble.infinity
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        //color: Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleMedium,
                // style: TextStyle(
                //   fontSize: 16,
                //   fontWeight: FontWeight.w400,
                //   color: Color(0xFFFFFCFC),
                // ),
              ),
              SizedBox(height: 4),
              Text(
                "${totalDoneTasks} Out of $totalTask Done",
                style: Theme.of(context).textTheme.titleSmall,
                // style: TextStyle(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w400,
                //   color: Color(0xFFC6C6C6),
                // ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: percent,
                    backgroundColor: Color(0xFF6D6D6D),

                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF15B86C),
                    ),
                    strokeWidth: 4,
                    // color: Color(0xFF15B86C),
                  ),
                ),
              ),
              Text(
                "${(percent * 100).toInt()} %",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
                // style: TextStyle(
                //   fontSize: 14,
                //   fontWeight: FontWeight.w500,
                //   color: Color(0xFFFFFCFC),
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
